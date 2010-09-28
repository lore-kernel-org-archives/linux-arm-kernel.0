From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 28 Sep 2010 21:35:11 +0800
Subject: [PATCH] [ARM] Introduce patching of phys_to_virt and vice versa
In-Reply-To: <alpine.LFD.2.00.1008091251460.10330@xanadu.home>
References: <1277542025-19881-1-git-send-email-eric.miao@canonical.com>
	<1278083164.15298.55.camel@ra7055-laptop>
	<20100720211629.GB10553@n2100.arm.linux.org.uk>
	<AANLkTimyif7CCoNwdKMCA=P+y=0e9uhwfhRchbMuB7eY@mail.gmail.com>
	<20100805094521.GB23473@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1008061256170.28809@xanadu.home>
	<20100808222402.GF23623@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1008091251460.10330@xanadu.home>
Message-ID: <AANLkTinttOaK4COroXBbruXeCyFztLsfdW85XXqTDMJO@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 10, 2010 at 12:55 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sun, 8 Aug 2010, Russell King - ARM Linux wrote:
>
>> On Fri, Aug 06, 2010 at 01:07:46PM -0400, Nicolas Pitre wrote:
>> > No idea. ?That depends how gcc is considering inline asm. ?Given there
>> > is one input operand, I suppose gcc would account for the delay slot
>> > before that operand is actually available.
>>
>> For something which could very well become by default enabled across
>> the board - due to the push to have a single kernel binary for lots
>> of significantly different platforms - it seems little research has
>> been carried out on this point.
>>
>> While I agree that other obvious solutions would be more expensive, I
>> think it makes sense to have the commit which is introducing this
>> method include a proper evaluation, not least so that people who need
>> to make the decision to enable this aren't repeating the same research
>> that someone else has done (or, worse, just decide to enable it 'just
>> because' without any understanding of what the effect may be.)
>
> Sure, I agree. ?I'll contact gcc people for a definitive answer.
>

Nico, any feedback?

>> I think we also need to consider whether the volatile is really required.
>> This asm() doesn't have any side effects other than its output operand,
>> so I suspect that the volatile may get in the way of some optimisations
>> (such as deleting the operation if the output is not actually used.)
>
> Indeed, the volatile should go. ?This is even getting in the way of
> better scheduling.
>

Yep. I don't see the necessity here for the volatile. Actually after removing
it, it resulted a better instruction scheduling.

I took example of arch/arm/mach-pxa/mioa701.c

static int mioa701_sys_suspend(struct sys_device *sysdev, pm_message_t state)
{
	int i = 0, is_bt_on;
	u32 *mem_resume_vector	= phys_to_virt(RESUME_VECTOR_ADDR);
	u32 *mem_resume_enabler = phys_to_virt(RESUME_ENABLE_ADDR);
	u32 *mem_resume_bt	= phys_to_virt(RESUME_BT_ADDR);
	u32 *mem_resume_unknown	= phys_to_virt(RESUME_UNKNOWN_ADDR);

with __volatile__ gcc gave me something like:

c004de44 <mioa701_sys_suspend>:
c004de44:	e1a0c00d 	mov	ip, sp
c004de48:	e92dd9f8 	push	{r3, r4, r5, r6, r7, r8, fp, ip, lr, pc}
c004de4c:	e24cb004 	sub	fp, ip, #4
c004de50:	e59f80d8 	ldr	r8, [pc, #216]	; c004df30 <mioa701_sys_suspend+0xec>
c004de54:	e2888000 	add	r8, r8, #0
c004de58:	e59f50d4 	ldr	r5, [pc, #212]	; c004df34 <mioa701_sys_suspend+0xf0>
c004de5c:	e2855000 	add	r5, r5, #0
c004de60:	e59f40d0 	ldr	r4, [pc, #208]	; c004df38 <mioa701_sys_suspend+0xf4>
c004de64:	e2844000 	add	r4, r4, #0
c004de68:	e59f70cc 	ldr	r7, [pc, #204]	; c004df3c <mioa701_sys_suspend+0xf8>
c004de6c:	e2877000 	add	r7, r7, #0
c004de70:	e59f30c8 	ldr	r3, [pc, #200]	; c004df40 <mioa701_sys_suspend+0xfc>
c004de74:	e3a00053 	mov	r0, #83	; 0x53


below was what generated after removing __volatile__:

c004de44 <mioa701_sys_suspend>:
c004de44:	e1a0c00d 	mov	ip, sp
c004de48:	e92dd9f8 	push	{r3, r4, r5, r6, r7, r8, fp, ip, lr, pc}
c004de4c:	e24cb004 	sub	fp, ip, #4
c004de50:	e59f30d8 	ldr	r3, [pc, #216]	; c004df30 <mioa701_sys_suspend+0xec>
c004de54:	e3a00053 	mov	r0, #83	; 0x53
c004de58:	e59f80d4 	ldr	r8, [pc, #212]	; c004df34 <mioa701_sys_suspend+0xf0>
c004de5c:	e5936008 	ldr	r6, [r3, #8]
c004de60:	e59f50d0 	ldr	r5, [pc, #208]	; c004df38 <mioa701_sys_suspend+0xf4>
c004de64:	e59f40d0 	ldr	r4, [pc, #208]	; c004df3c <mioa701_sys_suspend+0xf8>
c004de68:	e1a069a6 	lsr	r6, r6, #19
c004de6c:	e2166001 	ands	r6, r6, #1
c004de70:	13a01802 	movne	r1, #131072	; 0x20000
c004de74:	03a01801 	moveq	r1, #65536	; 0x10000
c004de78:	ebffee0a 	bl	c00496a8 <pxa2xx_mfp_set_lpm>
c004de7c:	e2888000 	add	r8, r8, #0
c004de80:	e2855000 	add	r5, r5, #0
c004de84:	e2844000 	add	r4, r4, #0
c004de88:	e59f30b0 	ldr	r3, [pc, #176]	; c004df40 <mioa701_sys_suspend+0xfc>
c004de8c:	e59f70b0 	ldr	r7, [pc, #176]	; c004df44 <mioa701_sys_suspend+0x100>
c004de90:	e2877000 	add	r7, r7, #0

Note those 'add rN, rN, #0' instructions are those stub instructions
for patching.

Does this also show something w.r.t an optimal instruction scheduling?

>
> Nicolas
>
