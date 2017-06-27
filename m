From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 27 Jun 2017 10:11:58 -0400
Subject: [PATCH v5] trace: ras: add ARM processor error information
 trace event
In-Reply-To: <918253cf-33ef-3152-a492-14f2b8946e99@huawei.com>
References: <1498275503-137890-1-git-send-email-xiexiuqi@huawei.com>
 <20170626093624.381a25cb@gandalf.local.home>
 <918253cf-33ef-3152-a492-14f2b8946e99@huawei.com>
Message-ID: <20170627101158.517f329c@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 27 Jun 2017 10:41:34 +0800
Xie XiuQi <xiexiuqi@huawei.com> wrote:

> Hi Steve,
> 
> Thanks for your comments.
> 
> On 2017/6/26 21:36, Steven Rostedt wrote:
> > On Sat, 24 Jun 2017 11:38:23 +0800
> > Xie XiuQi <xiexiuqi@huawei.com> wrote:
> >   
> >> diff --git a/include/linux/cper.h b/include/linux/cper.h
> >> index 4c671fc..17546bf 100644
> >> --- a/include/linux/cper.h
> >> +++ b/include/linux/cper.h
> >> @@ -275,6 +275,11 @@ enum {
> >>  #define CPER_ARM_INFO_FLAGS_PROPAGATED		BIT(2)
> >>  #define CPER_ARM_INFO_FLAGS_OVERFLOW		BIT(3)
> >>  
> >> +#define CPER_ARM_INFO_TYPE_CACHE		0
> >> +#define CPER_ARM_INFO_TYPE_TLB			1
> >> +#define CPER_ARM_INFO_TYPE_BUS			2
> >> +#define CPER_ARM_INFO_TYPE_UARCH		3
> >> +
> >>  /*
> >>   * All tables and structs must be byte-packed to match CPER
> >>   * specification, since the tables are provided by the system BIOS
> >> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> >> index 429f46f..dd91ba8 100644
> >> --- a/include/ras/ras_event.h
> >> +++ b/include/ras/ras_event.h
> >> @@ -206,6 +206,85 @@
> >>  		  __entry->running_state, __entry->psci_state)
> >>  );
> >>  
> >> +#define ARM_PROC_ERR_TYPE	\
> >> +	EM ( CPER_ARM_INFO_TYPE_CACHE, "cache error" )	\
> >> +	EM ( CPER_ARM_INFO_TYPE_TLB,  "TLB error" )	\
> >> +	EM ( CPER_ARM_INFO_TYPE_BUS, "bus error" )	\
> >> +	EMe ( CPER_ARM_INFO_TYPE_UARCH, "micro-architectural error" )  
> > 
> > These are all defines. As the name suggests, the TRACE_DEFINE_ENUM() is
> > for use with enums, not defines. You can nuke this part.
> >   
> >> +
> >> +/*
> >> + * First define the enums in MM_ACTION_RESULT to be exported to userspace
> >> + * via TRACE_DEFINE_ENUM().
> >> + */
> >> +#undef EM
> >> +#undef EMe
> >> +#define EM(a, b) TRACE_DEFINE_ENUM(a);
> >> +#define EMe(a, b)	TRACE_DEFINE_ENUM(a);
> >> +
> >> +ARM_PROC_ERR_TYPE
> >> +
> >> +/*
> >> + * Now redefine the EM() and EMe() macros to map the enums to the strings
> >> + * that will be printed in the output.
> >> + */
> >> +#undef EM
> >> +#undef EMe
> >> +#define EM(a, b)		{ a, b },
> >> +#define EMe(a, b)	{ a, b }  
> > 
> > All the EM* and friends above are not needed. The macro below will
> > translate into numbers not names in the format files in tracefs.  
> 
> So, do you mean we just use __print_symbolic like below:
> 
> #define show_proc_err_type(type)                                                \
>         __print_symbolic(type,                                                  \
>                 { CPER_ARM_INFO_TYPE_CACHE, "cache error" },                    \
>                 { CPER_ARM_INFO_TYPE_TLB, "TLB error" },                        \
>                 { CPER_ARM_INFO_TYPE_BUS, "bus error" },                        \
>                 { CPER_ARM_INFO_TYPE_UARCH, "micro-architectural error" })
> 
> 
> 

Correct. If you want to make sure, just boot the kernel and look at the
format file within the tracepoint:

 /sys/kernel/debug/tracing/events/ras/arm_err_info_event/format

And make sure there's no constant names there.

-- Steve
