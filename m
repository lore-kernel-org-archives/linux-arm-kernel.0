From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 24 May 2013 10:01:43 +0200
Subject: [PATCH 2/2] ARM: move VFP init to an earlier boot stage
In-Reply-To: <alpine.LFD.2.03.1305231654440.1918@syhkavp.arg>
References: <1369294104-3849-1-git-send-email-ard.biesheuvel@linaro.org>
 <1369294104-3849-2-git-send-email-ard.biesheuvel@linaro.org>
 <20130523084126.GI18614@n2100.arm.linux.org.uk>
 <alpine.LFD.2.03.1305231108500.1918@syhkavp.arg>
 <CAKv+Gu9FDprQtVitu5dojoWqY15s4ytOCxbFUjUnLsX8L92Zag@mail.gmail.com>
 <alpine.LFD.2.03.1305231654440.1918@syhkavp.arg>
Message-ID: <CAKv+Gu-O-ehYLp+yh5c=+d7NPOjqARRWLuidTgyNZP_DS2zaEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 May 2013 22:57, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Thu, 23 May 2013, Ard Biesheuvel wrote:
>> Currently, the lazy restore is armed even in kernel mode, so it pulls
>> in the userland context if you issue NEON/VFP instructions in kernel
>> mode with the FP unit off. This is probably a side effect of the VFP
>> detection code relying on this code path as well.
>> As kernel_vfp_begin() disarms the lazy restore and takes care of
>> preserving the userland context itself, entering __und_svc because of
>> NEON/VFP instructions should only be allowed in this particular case,
>> i.e., VFP detection and all other instances should BUG() imho
>> (regardless of if we end up doing NEON in the kernel or not). Doing it
>> that way, I don't think there is a reason for keeping additional
>> flags.
>
> The concern is more about VFP instructions that could trigger an
> exception where support code is invoked to emulate that instruction.
>

So perhaps that is where we should draw the line: I am not proposing
supporting arbitrary VFP code in the kernel, just NEON (which does not
bounce and hence does not require the support code). Maybe I should
rename to kernel_neon_begin/kernel_neon_end to reflect that?

Regards,
Ard.
