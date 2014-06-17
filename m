From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 17 Jun 2014 14:28:44 +0100
Subject: [PATCH v3] ARM: add get_user() support for 8 byte types
In-Reply-To: <20140617110908.GH23430@n2100.arm.linux.org.uk>
References: <1402587755-29245-1-git-send-email-daniel.thompson@linaro.org>
 <20140612155843.GK23430@n2100.arm.linux.org.uk> <53A015B3.2070809@linaro.org>
 <20140617110908.GH23430@n2100.arm.linux.org.uk>
Message-ID: <53A0428C.10200@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/06/14 12:09, Russell King - ARM Linux wrote:
> On Tue, Jun 17, 2014 at 11:17:23AM +0100, Daniel Thompson wrote:
>> ... at this point there is a narrowing cast followed by an implicit
>> widening. This results in compiler either ignoring r3 altogether or, if
>> spilling to the stack, generating code to set r3 to zero before doing
>> the store.
> 
> In actual fact, there's very little difference between the two
> implementations in terms of generated code.
> 
> The difference between them is what happens on the 64-bit big endian
> narrowing case, where we use __get_user_4 with your version.  This
> adds one additional instruction.

Good point.


> and 64-bit narrowed to 32-bit:
> 
>         str     lr, [sp, #-4]!
> -       mov     ip, r0
> +       mov     r3, r0
>         mov     r0, r1
>  #APP
>  @ 275 "t-getuser.c" 1
> -       bl      __get_user_8
> +       bl      __get_user_4
>  @ 0 "" 2
> -       str     r2, [ip, #0]
> +       str     r2, [r3, #0]
>         ldr     pc, [sp], #4

The later case avoids allocating r3 for the __get_user_x and should
reduce register pressure and, potentially, saves a few instructions
elsewhere (one of my rather large test functions does demonstrate this
effect).

I don't know if we care about that. If we do I'm certainly happy to put
a patch together than exploits this (whilst avoiding the add in the big
endian case).


Daniel.
