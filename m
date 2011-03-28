From: viktor.rosendahl@nokia.com (Viktor Rosendahl)
Date: Mon, 28 Mar 2011 19:27:59 +0300
Subject: [PATCH] kprobes/arm: fix emulation of LDR/STR instruction when
	Rn == PC
In-Reply-To: <1301087944.2744.85.camel@computer2.home>
References: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
	<1301087944.2744.85.camel@computer2.home>
Message-ID: <4D90B70F.7050108@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2011 11:19 PM, ext Tixy wrote:
>
>> Regarding the second point above, it would possibly be prudent to add some
>> checking to prep_emulate_ldr_str(), so that instructions with write back and
>> Rn == PC would be rejected.
>
> I don't think it is worth adding code to check for illegal instructions.
> The toolchain shouldn't generate them in the first place, and there are
> many places in the kprobe code which doesn't bother checking; there are
> even comments like "may be invalid, don't care".

I think those "may be invalid, don't care" comments mostly are about the 
Rm value, which isn't valid for some fully legal variants of the 
instruction, those instructions that have the immediate bit set. In that 
case the Rm value, will actually be part of an immediate and thus bogus. 
However, it will not impact the result of the emulation because the 
instruction will not read from the r2 register. It's enough to check the 
immediate bit in the prep_emulate_*() functions; if you check for 
example the prep_emulate_ldr_str() function you will se that it actually 
does it before adjusting Rm to r2.

To summarize, I think the "may be invalid, don't care" comments simply 
mean "This value may be bogus but in that case it will not impact the 
result of the emulation so we don't care".

>
> I'm currently working on implementing Thumb support in kprobes and am
> writing test code as part of that. I planned on adding test cases for
> ARM so hopefully will catch a few more instruction emulation bugs (if
> there are any to be found).
>

Nice.
