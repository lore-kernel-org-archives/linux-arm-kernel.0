From: james.morse@arm.com (James Morse)
Date: Wed, 16 Dec 2015 09:30:34 +0000
Subject: [PATCH v12 08/16] arm64/kexec: Add core kexec support
In-Reply-To: <20151216071804.GI4674@dhcppc13.redhat.com>
References: <cover.1448403503.git.geoff@infradead.org>
 <6ac232ad37d6b02cf2d5848b15236f26f5ac61ac.1448403503.git.geoff@infradead.org>
 <20151215182932.GF353@arm.com> <1450224870.24127.130.camel@infradead.org>
 <20151216071804.GI4674@dhcppc13.redhat.com>
Message-ID: <56712F3A.7040805@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/12/15 07:18, Pratyush Anand wrote:
> On 15/12/2015:04:14:30 PM, Geoff Levand wrote:
>> On Tue, 2015-12-15 at 18:29 +0000, Will Deacon wrote:
>>>> +> > 	> >  * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
>>>> +> > 	> >  * after the kernel is shut down.
>>>> +> > 	> >  */
>>>> +> > 	> > memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
>>>> +> > 	> > 	> > arm64_relocate_new_kernel_size);
>>>
>>> At which point does the I-cache get invalidated for this?
>>
>> I'll add a call to flush_icache_range() for reboot_code_buffer.  I
>> think that should do it.
> 
> We execute arm64_relocate_new_kernel() code with I-cache disabled. So, do we
> really need to invalidate I-cache?

I got bitten by this, see Mark's earlier reply[0]:

Mark Rutland wrote:
> The SCTLR_ELx.I only affects the attributes that the I-cache uses to
> fetch with, not whether it is enabled (it cannot be disabled
> architecturally).



James


[0]
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/382101.html
