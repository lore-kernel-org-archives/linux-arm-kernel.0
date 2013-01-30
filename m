From: david.woodhouse@intel.com (Woodhouse, David)
Date: Wed, 30 Jan 2013 10:22:15 +0000
Subject: [RFC] arm: use built-in byte swap function
In-Reply-To: <20130129181046.GC25415@pd.tnic>
References: <20130128193033.8a0b0a871150c99247f05a95@freescale.com>
 <20130129083522.GA14302@pd.tnic>
 <1359478014.3529.157.camel@shinybook.infradead.org>
 <20130129174249.GB25415@pd.tnic>
 <1359482147.3529.161.camel@shinybook.infradead.org>
 <20130129181046.GC25415@pd.tnic>
Message-ID: <1359541333.3529.186.camel@shinybook.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-29 at 19:10 +0100, Borislav Petkov wrote:
> So, IMHO it sounds to me like we want to explicitly state for each arch
> separately that it is ok to use the __builtin_bswapXX things. This also
> takes care of the case where the compiler is doing something suboptimal
> by excluding the affected versions.

Well, if it really does end up being different for every architecture,
then that means I probably made the wrong decision when I chose to make
it "generic", and override the __arch_swabXX() macros. I could have just
pushed all the architectures to use the builtins in their __arch_swabXX
macros instead, as appropriate.

Let's see how many special cases we actually end up with, and perhaps
we'll end up switching that round. For now, let's just make ARM set
__HAVE_BUILTIN_BSWAPxx__ for the appropriate sizes in <asm/swab.h>,
according to whatever criteria it needs.

It's not entirely clear how much of a win it is on ARM anyway; we don't
have load-and-swap or store-and-swap instructions so there are only a
few added opportunities for optimisation that we get by letting the
compiler see what's going on.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130130/366a3921/attachment.bin>
