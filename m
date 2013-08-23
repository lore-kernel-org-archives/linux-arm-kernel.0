From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Fri, 23 Aug 2013 11:30:18 +0200
Subject: [RFC 17/17] clk: zynq: remove call to of_clk_init
In-Reply-To: <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376964271-22715-18-git-send-email-sebastian.hesselbarth@gmail.com>
 <d17acba9-85f9-40cd-a176-2005e3e924f8@CO1EHSMHS002.ehs.local>
 <c4d10bdf-6506-4edc-92cc-2acc67b86602@VA3EHSMHS032.ehs.local>
Message-ID: <52172BAA.7020009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/13 02:59, S?ren Brinkmann wrote:
> On Thu, Aug 22, 2013 at 05:26:47PM -0700, S?ren Brinkmann wrote:
>> On Tue, Aug 20, 2013 at 04:04:31AM +0200, Sebastian Hesselbarth wrote:
>>> With arch/arm calling of_clk_init(NULL) from time_init(), we can now
>>> remove it from corresponding drivers/clk code.
>>
>> I think that would break Zynq.
>> If I see this correctly you call of_clk_init() from common code,
>> _before_ the SOC specific time init function is called.
>> The problem is, that we have code setting up a global pointer which is
>> required by zynq_clk_setup() which is triggered when of_clk_init() is
>> called.
>>
>> Let me try to illustrate the current call graph:
>>
>> time_init()
>> 	zynq_timer_init()		// this machines init_time()
>> 		zynq_slcr_init()	// setup System Level Control Registers including a global pointer
>> 			zynq_clock_init()
>> 				of_clk_init()
>> 					zynq_clk_setup()   // requires pointer setup in zynq_slcr_init()
>> 					...
>>
>> IIUC, your series would change this to:
>> time_init()
>> 	of_clk_init()
>> 		zynq_clk_setup()	// SLCR pointer is not setup/NULL
>> 		...
>> 	zynq_timer_init()
>> 		zynq_slcr_init()	// now the pointer becomes valid
>
> I guess we could move zynq_slcr_init() into init_irq(). I'll give that a
> shot tomorrow.

S?ren,

thanks for looking into this. I also had a look at the files in
question. Based on Steffen's proposal, I prepared a diff that should do
the trick. It moves zynq_slcr_init() to early_init, instead of reusing
another hook that has magic cow powers (it calls irqchip_init that zynq
also wants sooner or later).

Also, it removes zynq_clock_init() and let zynq_clk_setup() map the
register itself by finding the node and use of_iomap(). I realized that
clock registers are quite separated within slcr, so you can consider
to have your own node for the clk-provider. As Steffen is proposing
this but mentioned incompatible DT changes, I chose that intermediate
step above.

It would be great, if you test the diff and prepare a patch out of
it, that I pick-up in the patch set. That way, we also have your
Signed-off on it.

Sebastian


-------------- next part --------------
A non-text attachment was scrubbed...
Name: arm-of_clk_init-zynq-proposal.diff
Type: text/x-patch
Size: 3117 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130823/cfed70c7/attachment-0001.bin>
