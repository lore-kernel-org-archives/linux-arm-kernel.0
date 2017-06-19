From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 19 Jun 2017 18:43:48 +0100
Subject: [PATCH v3 2/4] asm-generic: Provide a fncpy() implementation
In-Reply-To: <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
References: <20170617000744.22158-1-f.fainelli@gmail.com>
 <20170617000744.22158-3-f.fainelli@gmail.com>
 <20170618235108.peaxdi367jpkt542@yury-thinkpad>
 <20170619151818.pvjygbdvm6arvarq@yury-thinkpad>
Message-ID: <20170619174348.GA23750@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 06:18:18PM +0300, Yury Norov wrote:
> One else thing I forgot to ask - now you have the generic
> implementation for fncpy(), so do you really need to save arm
> version of it?

This was covered in the review of v1, which took the ARM version
and incorrectly used it as an asm-generic implementation.

I explicitly asked Florian _not_ to copy the ARM fncpy() version
to asm-generic because it has (surprise surprise) ARM specific
behaviours that do not belong in a cross-architecture generic
version.

Namely, the ARM specific behaviour that bit 0 of a code address is
used to signal whether the code should be executed as ARM code or
as Thumb code.

This behaviour has no meaning on other architectures (eg, x86)
where code addresses are not 32-bit aligned.

So, suggesting that the ARM fncpy() should be used as an asm-generic
version is completely absurd, and just because we have an asm-generic
version also does not mean ARM should use it.

Florian's approach to providing an asm-generic version, leaving the
ARM specific version is entirely correct and appropriate.

So, in answer to your question, yes, we need _both_ an ARM specific
version and an asm-generic version, where the ARM specific version is
different from the asm-generic version.  Purely because it needs
architecture specific details.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
