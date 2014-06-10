From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Tue, 10 Jun 2014 10:40:40 -0300
Subject: [RFC/PATCH] ARM: mvebu: Don't apply the quirks if the SoC
 revision is unknown
In-Reply-To: <5621673.VW5TXctBgm@wuerfel>
References: <1402342036-9168-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <5621673.VW5TXctBgm@wuerfel>
Message-ID: <20140610134040.GA1991@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Thanks for taking a look.

On 10 Jun 10:21 AM, Arnd Bergmann wrote:
> On Monday 09 June 2014 16:27:16 Ezequiel Garcia wrote:
> > We currently skip the I2C and thermal quirks only if the SoC revision is
> > known to be one that does not need them. If the SoC revision cannot be
> > obtained, the current behavior is to apply the quirk assuming it's needed.
> > 
> > This commit changes this, by requiring the SoC revision to be known in order
> > to peform a quirk.
> 
> This clearly needs a better description if we want to apply it. We had
> a rather long discussion when the code was first added exactly this
> way and you should explain which of the assumptions we made back then
> are now incorrect.
> 
> Is it ever wrong (as opposed to inefficient) to apply the quirk even on a
> newer SoC?
> 

Yes, for the thermal quirk it is wrong as it consists in changing the compatible
string and moving the registers around.

So if you apply the quirk on a SoC that doesn't need it, thermal won't work.

> IIRC, the reasoning was that almost all machines have the new SoC version,

Agreed, and that's why I think it's better to *not* apply the quirk unless the
SoC revision can be properly obtained and matched as needing it.

> so they should have their DTs marked with the correct IDs already.
> 

Hm.. I guess the I2C and thermal quirks don't work the same way. Here's how
the latter works.

The driver supports two different compatible strings:
"armada375-thermal" and "armada375-z1-thermal". However, we don't expect the
user to know the revision, so the quirk code detects the SoC revision and
changes the compatible string if needed.

In addition, given the register offsets are different in the Z1 revision,
we workaround that by moving them in the quirk code, before the thermal
driver probes.

So, there's no "correct ID in the devicetree", as we assume the devicetree
works for the new SoC and only apply changes if we detect the SoC revision
needs the workaround.

Under this scheme, this commit makes a requirement to know the SoC revision
before applying a quirk, where the current code applies it blindly.

However, I'm not sure if this is correct for the I2C quirk. Maybe I was
too fast assuming it was.
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
