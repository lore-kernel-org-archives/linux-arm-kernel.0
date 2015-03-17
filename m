From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 16:51:40 +0100
Subject: [PATCH] arm: crypto: Add NEON optimized SHA-256
In-Reply-To: <550843B4.8080903@openssl.org>
References: <20150316154835.GA31336@google.com>
 <CAKv+Gu8+oQ13j61X6x70baJXOpEiM2L+vK=KgK1JG12sy5KMsg@mail.gmail.com>
 <20150316162304.GA35408@google.com>
 <CAKv+Gu8fmBYwfrMKRqhA5KhU1HNjMP1cLtpmgCmp78R4CUw3fg@mail.gmail.com>
 <550843B4.8080903@openssl.org>
Message-ID: <CAKv+Gu_TK7BX5V-WD-L0tzTz6SoSfpUOjxboTawiAeRi=MbQ=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 16:09, Andy Polyakov <appro@openssl.org> wrote:
> Hi,
>
>>>> Have you tested this code with the tcrypt.ko module?
>>>
>>> I have not, but I can look into it.
>>>
>>>> Did you talk to Andy about the license? I don't think this is
>>>> permissible for the kernel as-is.
>>>
>>> Unless I have misunderstood something, the license at the Cryptogams
>>> website includes an option to license the code under the GNU GPL.
>>>
>>> However, I can certainly contact Andy to clarify his intentions.
>
> I have no problems with reusing assembly modules in kernel context. The
> whole idea behind cryptogams initiative was exactly to reuse code in
> different contexts. But I'd prefer if it's more of cooperative effort,
> when we help each other to improve code, test on and tune for more
> platforms single developer might have access to, cross-report problems,
> etc. For this reason I'd prefer if it can be arranged in way similar to
> bsaes-armv7 module, i.e. we work together on shared copy of module that
> generates assembly that can be then compiled for OpenSSL or kernel. Is

Yes, that is what I thought.

@Sami, this also means we should integrate the .pl file and the
generated .S. Please have a look at how I integrated Andy's
bsaes-armv7.pl module.

> it sensible? BTW, why stop at SHA256? There is SHA512 and NEON SHA1...
>
> As for practicalities. In order to spare brain capacity for list
> subscribers, it would probably be appropriate to work out details such
> as naming of entry points in smaller group and present result when it's
> ready to go and tests. I'll start by looking at Thumb-ification...
>

@Andy: the core code builds without problems, but for Thumb2 there are
some trivial changes to apply:
- '.code 32' needs to be made conditional
- use adr instead of pc arithmetic for the address of K256
- bic cannot use r13 as input/output, so it needs to go via another register
- some conditional instructions need 'it' instructions added (not
strictly necessary for the kernel, because it passes
-mimplicit-it-thumb on the assembler command line, but nice for
completeness)
(see patch in other reply)

I am happy to test and/or review stuff as well.

Thanks,
Ard.
