From: will.deacon@arm.com (Will Deacon)
Date: Thu, 13 Sep 2018 18:38:40 +0100
Subject: [PATCH] asm-generic: io: Fix ioport_map() for
 !CONFIG_GENERIC_IOMAP && CONFIG_INDIRECT_PIO
In-Reply-To: <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
References: <1536842907-51732-1-git-send-email-andrew.murray@arm.com>
 <CAK8P3a27Qx=A9zNheYNF2oZaRUQm-4h_8nPUF2xTdL+kqFrV5g@mail.gmail.com>
Message-ID: <20180913173840.GB20290@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 13, 2018 at 04:00:54PM +0200, Arnd Bergmann wrote:
> On Thu, Sep 13, 2018 at 2:48 PM Andrew Murray <andrew.murray@arm.com> wrote:
> >
> > The !CONFIG_GENERIC_IOMAP version of ioport_map uses MMIO_UPPER_LIMIT to
> > prevent users from making I/O accesses outside the expected I/O range -
> > however it erroneously treats MMIO_UPPER_LIMIT as a mask which is
> > contradictory to its other users.
> >
> > The introduction of CONFIG_INDIRECT_PIO, which subtracts an arbitrary
> > amount from IO_SPACE_LIMIT to form MMIO_UPPER_LIMIT, results in ioport_map
> > mangling the given port rather than capping it.
> >
> > We address this by aligning more closely with the CONFIG_GENERIC_IOMAP
> > implementation of ioport_map by using the comparison operator and
> > returning NULL where the port exceeds MMIO_UPPER_LIMIT. Though note that
> > we preserve the existing behavior of masking with IO_SPACE_LIMIT such that
> > we don't break existing buggy drivers that somehow rely on this masking.
> >
> > Fixes: 5745392e0c2b ("PCI: Apply the new generic I/O management on PCI IO hosts")
> > Reported-by: Will Deacon <will.deacon@arm.com>
> > Signed-off-by: Andrew Murray <andrew.murray@arm.com>
> 
> Looks good to me,
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> Can you take this through the arm64 tree?

Yup, I'll queue it up as a fix.

Cheers,

Will
