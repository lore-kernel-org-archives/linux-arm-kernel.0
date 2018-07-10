From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 10 Jul 2018 18:56:09 +0200
Subject: 4.18rc3 TX2 boot failure with "ACPICA: AML parser: attempt to
 continue loading table after error"
In-Reply-To: <dc4c68bb-089c-6c99-31df-e8d3587b6029@arm.com>
References: <c49a3666-7d23-6a05-703c-1273d79a00cd@arm.com>
 <2264016.O8iB3BUh2s@aspire.rjw.lan>
 <dc4c68bb-089c-6c99-31df-e8d3587b6029@arm.com>
Message-ID: <24702482.jSiYyYTB4u@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 10, 2018 5:04:21 PM CEST Jeremy Linton wrote:
> Hi,
> 
> On 07/10/2018 06:25 AM, Rafael J. Wysocki wrote:
> > On Tuesday, July 10, 2018 1:13:17 PM CEST Rafael J. Wysocki wrote:
> >> On Tuesday, July 10, 2018 5:44:05 AM CEST Jeremy Linton wrote:
> >>> Hi,
> >>>
> >>> On 07/09/2018 04:28 PM, Rafael J. Wysocki wrote:
> >>>> On Mon, Jul 9, 2018 at 10:45 PM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> >>>>> Hi,
> >>>>>
> >>>>> First thanks for the patch..
> >>>>>
> >>>>> On 07/08/2018 04:14 AM, Rafael J. Wysocki wrote:
> >>>>>>
> >>>>>> On Monday, July 2, 2018 11:41:42 PM CEST Jeremy Linton wrote:
> >>>>>>>
> >>>>>>> Hi,
> >>>>>>>
> >>>>>>> I'm experiencing two problems with commit 5088814a6e931 which is
> >>>>>>> "ACPICA: AML parser: attempt to continue loading table after error"
> >>>>>>>
> >>>>>>> The first is this boot failure on a thunderX2:
> >>>>>>>
> >>>>>>> [   10.770098] ACPI Error: Ignore error and continue table load
> >>>>>
> >>>>>
> >>>>> [trimming]
> >>>>>
> >>>>>>> ]---
> >>>>>>>
> >>>>>>> Which does appear to be the result of some bad data in the table, but it
> >>>>>>> was working with 4.17, and reverting this commit solves the problem.
> >>>>>>
> >>>>>>
> >>>>>> Does the patch below make any difference?
> >>>>>>
> >>>>>> ---
> >>>>>>     drivers/acpi/acpica/psobject.c |    3 +++
> >>>>>>     1 file changed, 3 insertions(+)
> >>>>>>
> >>>>>> Index: linux-pm/drivers/acpi/acpica/psobject.c
> >>>>>> ===================================================================
> >>>>>> --- linux-pm.orig/drivers/acpi/acpica/psobject.c
> >>>>>> +++ linux-pm/drivers/acpi/acpica/psobject.c
> >>>>>> @@ -39,6 +39,9 @@ static acpi_status acpi_ps_get_aml_opcod
> >>>>>>           ACPI_FUNCTION_TRACE_PTR(ps_get_aml_opcode, walk_state);
> >>>>>>           walk_state->aml = walk_state->parser_state.aml;
> >>>>>> +       if (!walk_state->aml)
> >>>>>> +               return AE_CTRL_PARSE_CONTINUE;
> >>>>>> +
> >>>>>
> >>>>>
> >>>>> Well this seems to avoid the crash, but now it hangs right after on the
> >>>>> "Ignore error and continue table load" message.
> >>>>
> >>>> Well, maybe we should just abort in that case.
> >>>>
> >>>> I'm wondering what happens if you replace the return statement in the
> >>>> patch above with
> >>>>
> >>>> return_ACPI_STATUS(AE_AML_BAD_OPCODE)
> >>>
> >>> Yes, that is where I went when I applied the patch but I used
> >>> AE_CTRL_TERMINATE, which terminates the loop in acpi_ps_parse_loop() and
> >>> that appears to successfully finish/terminate the initial parsing pass.
> >>> But, it then crashes in acpi_ns_lookup called via the
> >>> acpi_walk_resources sequences that goes through ut_evalute_object() due
> >>> to the path/scope_info->scope.node being ACPI_ROOT_OBJECT (-1) and
> >>> bypassing the null check. Adding a ACPI_ROOT_OBJECT check as well as the
> >>> null checks in acpi_ns_lookup results in a successful boot. Tracking
> >>> down how the terminate (or whatever) is leaving the info->prefix_node
> >>> (in acpi_ns_evaluate) set to ROOT_OBJECT instead of null, is something I
> >>> don't yet understand.
> >>>
> >>> Anyway, I tried Using BAD_OPCODE rather than TERMINATE and it seems to
> >>> have the same basic result as PARSE_CONTINUE.
> >>
> >> OK, thanks!
> >>
> >> I evidently didn't look deep enough.
> >>
> >> Can you please check the patch below?
> >>
> >> I'm not sure if we can pass this broken state to
> >> acpi_ps_complete_final_op(), so it may be necessary to return
> >> an error directly when aml_op_start is NULL.
> >>
> >> ---
> >>   drivers/acpi/acpica/psloop.c |    3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> Index: linux-pm/drivers/acpi/acpica/psloop.c
> >> ===================================================================
> >> --- linux-pm.orig/drivers/acpi/acpica/psloop.c
> >> +++ linux-pm/drivers/acpi/acpica/psloop.c
> >> @@ -493,6 +493,9 @@ acpi_status acpi_ps_parse_loop(struct ac
> >>   		ASL_CV_CAPTURE_COMMENTS(walk_state);
> >>   
> >>   		aml_op_start = parser_state->aml;
> >> +		if (!aml_op_start)
> >> +			break;
> >> +
> >>   		if (!op) {
> >>   			status =
> >>   			    acpi_ps_create_op(walk_state, aml_op_start, &op);
> >>
> >> --
> > 
> > So maybe something like this:
> > 
> > ---
> >   drivers/acpi/acpica/psloop.c |    3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > Index: linux-pm/drivers/acpi/acpica/psloop.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/acpica/psloop.c
> > +++ linux-pm/drivers/acpi/acpica/psloop.c
> > @@ -494,6 +494,9 @@ acpi_status acpi_ps_parse_loop(struct ac
> >   
> >   		aml_op_start = parser_state->aml;
> >   		if (!op) {
> > +			if (!aml_op_start)
> > +				return_ACPI_STATUS(AE_AML_INTERNAL);
> > +
> >   			status =
> >   			    acpi_ps_create_op(walk_state, aml_op_start, &op);
> >   			if (ACPI_FAILURE(status)) {
> > 
> > 
> 
> This gets rid of the infinite loop, but its still has the problem with 
> acpi_ns_lookup crashing due to -1 in the scope.node.

OK, so do you mean that something like the patch below is needed for the
system to boot?

---
 drivers/acpi/acpica/nsaccess.c |    3 ++-
 drivers/acpi/acpica/psloop.c   |    3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/acpica/psloop.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/psloop.c
+++ linux-pm/drivers/acpi/acpica/psloop.c
@@ -494,6 +494,9 @@ acpi_status acpi_ps_parse_loop(struct ac
 
 		aml_op_start = parser_state->aml;
 		if (!op) {
+			if (!aml_op_start)
+				return_ACPI_STATUS(AE_AML_INTERNAL);
+
 			status =
 			    acpi_ps_create_op(walk_state, aml_op_start, &op);
 			if (ACPI_FAILURE(status)) {
Index: linux-pm/drivers/acpi/acpica/nsaccess.c
===================================================================
--- linux-pm.orig/drivers/acpi/acpica/nsaccess.c
+++ linux-pm/drivers/acpi/acpica/nsaccess.c
@@ -286,7 +286,8 @@ acpi_ns_lookup(union acpi_generic_state
 
 	/* Get the prefix scope. A null scope means use the root scope */
 
-	if ((!scope_info) || (!scope_info->scope.node)) {
+	if ((!scope_info) || (!scope_info->scope.node) ||
+	    (scope_info->scope.node == ACPI_ROOT_OBJECT)) {
 		ACPI_DEBUG_PRINT((ACPI_DB_NAMES,
 				  "Null scope prefix, using root node (%p)\n",
 				  acpi_gbl_root_node));
