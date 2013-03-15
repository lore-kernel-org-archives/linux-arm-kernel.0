From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Mar 2013 10:15:00 +0000
Subject: [PATCH] isdn: hisax: netjet requires VIRT_TO_BUS
In-Reply-To: <CAMuHMdVhjnX_hag5Y5VvDWVcjPK8tMM-qx-TQ2x=M88yTZQwYg@mail.gmail.com>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-4-git-send-email-arnd@arndb.de>
 <CAMuHMdVhjnX_hag5Y5VvDWVcjPK8tMM-qx-TQ2x=M88yTZQwYg@mail.gmail.com>
Message-ID: <201303151015.00746.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 March 2013, Geert Uytterhoeven wrote:
> On Thu, Mar 14, 2013 at 10:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > Disabling CONFIG_VIRT_TO_BUS on ARM showed that the hisax netjet
> > driver depends on this deprecated functionality but is not
> > marked so in Kconfig.
> >
> > Rather than adding ARM to the already long list of architectures
> > that this driver is broken on, this patch adds 'depends on
> > VIRT_TO_BUS' and removes the dependency on !SPARC, which is
> > also implied by that.
> 
> IIRC, the real "arch" dependency for this driver is !BIG_ENDIAN, but
> unfortunately
> we don't have a generic Kconfig symbol for that.
> Perhaps we may want to introduce that?
> Of course we prefer to make drivers work on all endianness instead...

CONFIG_VIRT_TO_BUS is certainly also a dependency, since it fails
to build without that. I think we can address the two problems separately.

David Howells brought up the topic of endian checks recently, noting
that the way we define __BIG_ENDIAN and __LITTLE_ENDIAN in the kernel
is incompatible to how do it in user space, and not much better either.

A few architectures that are bi-endian (arc, arm, c6x, mips, sh) already
have CONFIG_CPU_IS_LITTLE_ENDIAN and CONFIG_CPU_IS_BIG_ENDIAN. I guess
it would be a good idea to provide these on all architectures.

	Arnd
