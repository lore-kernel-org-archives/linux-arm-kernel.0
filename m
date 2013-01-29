From: david.woodhouse@intel.com (Woodhouse, David)
Date: Tue, 29 Jan 2013 14:43:23 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130129141328.GV23505@n2100.arm.linux.org.uk>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129141328.GV23505@n2100.arm.linux.org.uk>
Message-ID: <1359470601.3529.120.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 14:13 +0000, Russell King - ARM Linux wrote:
> 
> So, this compiler (4.5.4) has support for 32-bit and 64-bit bswaps
> across all our architectures, but not the 16-bit ones.

That observation is consistent with my dig through GCC history. I had
come to the conclusion that the 32-bit and 64-bit versions were added
*generically* in 4.4, and that the 16-bit version was added in 4.6 to
that PowerPC back end, and made generic in 4.8. So I *had* put that
arch-specific check into compiler-gcc4.h, for PowerPC. It's just outside
the context of Kim's patch. If it really does end up being different for
every arch, I may reconsider that.

As for the __bswapsi2() calls... if it's ever emitting an out-of-line
call for something like that, that seems like a really dubious decision;
surely it's better being inlined? So rather than adding it to your
bits-of-libgcc.a in the kernel, I'd suggest just *not* using
ARCH_USE_BUILTIN_BSWAP for the offending compilers, and filing a bug to
get them fixed.

But really, this is why I created ARCH_USE_BUILTIN_BSWAP and left it to
architecture maintainers to enable it at their leisure.... :)

-- 
                   Sent with MeeGo's ActiveSync support.

David Woodhouse                            Open Source Technology Centre
David.Woodhouse at intel.com                              Intel Corporation



-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 4370 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130129/301d4e82/attachment.bin>
