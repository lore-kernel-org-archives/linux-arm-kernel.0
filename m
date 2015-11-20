From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 20 Nov 2015 17:32:38 +0000
Subject: [Xen-devel] [PATCH 11/13] xen/hvm/params: Add a new dilivery
 type for event-channel in HVM_PARAM_CALLBACK_IRQ
In-Reply-To: <564F56C9.8060007@citrix.com>
References: <1447754231-7772-1-git-send-email-shannon.zhao@linaro.org>
 <1447754231-7772-12-git-send-email-shannon.zhao@linaro.org>
 <alpine.DEB.2.02.1511201706070.1107@kaball.uk.xensource.com>
 <564F56C9.8060007@citrix.com>
Message-ID: <alpine.DEB.2.02.1511201732070.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 20 Nov 2015, Andrew Cooper wrote:
> On 20/11/15 17:07, Stefano Stabellini wrote:
> > On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> >> From: Shannon Zhao <shannon.zhao@linaro.org>
> >>
> >> Add a new dilivery type:
> > delivery
> >
> >> val[63:56] == 3: val[15:8] is flag: val[7:0] is a PPI.
> >> To the flag, bit 0 stands the interrupt mode is edge(1) or level(0) and
> >> bit 1 stands the interrupt polarity is active low(1) or high(0).
> >>
> >> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>
> >> ---
> >>  include/xen/interface/hvm/params.h | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/include/xen/interface/hvm/params.h b/include/xen/interface/hvm/params.h
> >> index a6c7991..550688a 100644
> >> --- a/include/xen/interface/hvm/params.h
> >> +++ b/include/xen/interface/hvm/params.h
> >> @@ -34,6 +34,11 @@
> >>   *                  Domain = val[47:32], Bus  = val[31:16],
> >>   *                  DevFn  = val[15: 8], IntX = val[ 1: 0]
> >>   * val[63:56] == 2: val[7:0] is a vector number.
> >> + * val[63:56] == 3: val[15:8] is flag of event-channel interrupt:
> >> + *                      bit 0: interrupt is edge(1) or level(0) triggered
> >> + *                      bit 1: interrupt is active low(1) or high(0)
> >> + *                  val[7:0] is PPI number used by event-channel.
> >> + *                  This is only used by ARM/ARM64.
> >>   * If val == 0 then CPU0 event-channel notifications are not delivered.
> >>   */
> >>  #define HVM_PARAM_CALLBACK_IRQ 0
> 
> Sadly NACK in this form.
> 
> This is not your fault, but this particular field has hidden ABI which
> the original submitter neglected to put into public API.
> 
> Bits 63:56 of this field currently have a hidden ABI with:
> 
> xen/include/asm-x86/hvm/irq.h
> enum {
>     HVMIRQ_callback_none,
>     HVMIRQ_callback_gsi,
>     HVMIRQ_callback_pci_intx,
>     HVMIRQ_callback_vector
> } callback_via_type;
 
I take the value should be "4" then?


> I will submit a patch to fix this this properly.
