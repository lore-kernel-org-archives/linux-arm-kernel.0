From: appro@openssl.org (Andy Polyakov)
Date: Fri, 27 Mar 2015 11:42:55 +0100
Subject: [PATCHv2] arm: crypto: Add optimized SHA-256/224
In-Reply-To: <CAKv+Gu_4G69JZJPex_=1xOZ4z5Fxtht4YG4G=TnYrkXPuiXvFg@mail.gmail.com>
References: <20150316154835.GA31336@google.com>	<20150323135009.GB820@google.com>	<20150324122702.GJ14457@ns203013.ovh.net>	<CAKv+Gu-j8m7NAYHL8swjwJ0as6TzNyjqhk0Tp1QhDhH=E78K3Q@mail.gmail.com>	<20150324130511.GK14457@ns203013.ovh.net>	<CAKv+Gu8Px6dYKdrVFyh_5WN3sEAGYy0fv0qHONJ5x+68YZjCOQ@mail.gmail.com>
 <CAKv+Gu_4G69JZJPex_=1xOZ4z5Fxtht4YG4G=TnYrkXPuiXvFg@mail.gmail.com>
Message-ID: <5515342F.6010703@openssl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Could you share the error log please?
> 
> OK, I spotted one issue with this code:
> 
> arch/arm/crypto/sha256-core.S: Assembler messages:
> arch/arm/crypto/sha256-core.S:1847: Error: invalid constant (ffffefb0)
> after fixup
> 
> This is caused by the fact that, when building the integer-only code
> for an older architecture, the conditional compilation produces a
> slightly bigger preceding function, and the symbol K256 is out of
> range for the adr instruction.
> 
> @Jean-Christophe: is that the same problem that you hit?
> 
> @Andy: I propose we do something similar as in the bsaes code:
> 
> #ifdef __thumb__
> #define adrl adr
> #endif
> 
> and replace the offending line with
> 
> adrl r14,K256

Sorry about delay. Yes, that would do. I did test all combinations, but
all "my" combinations, i.e. without __KERNEL__ defined :-( And without
__KERNEL__ there are few extra instructions in integer-only subroutine
that "push" instruction in question code toward higher address, so that
constant was ffffefc0, which can be encoded. Anyway, I've chosen to add
that #define next to .thumb directive. See attached.

Ard, you have mentioned that you've verified it on big-endian, but I've
spotted little-endian dependency (see #ifndef __ARMEB__ in attached). I
guess that it worked for you either because it was NEON that was tested
(it does work as is) or __LINUX_ARM_ARCH__ was less than 7 (in which
case it uses endian-neutral byte-by-byte data load). Can you confirm either?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sha256-armv4.diff
Type: text/x-patch
Size: 838 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150327/6d108844/attachment.bin>
