From: bhe@redhat.com (Baoquan He)
Date: Wed, 15 Jun 2016 10:43:03 +0800
Subject: kexec failures with DEBUG_RODATA
In-Reply-To: <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
References: <20160614175920.GD1041@n2100.armlinux.org.uk>
 <CAGXu5j+5j32HO0rQtF2hcqMUBaa8cyxgLT4JvaZ6LL2WPj_zjw@mail.gmail.com>
Message-ID: <20160615024303.GA7720@x1.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/16 at 11:05am, Kees Cook wrote:
> On Tue, Jun 14, 2016 at 10:59 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Since the kernel now has CONFIG_DEBUG_RODATA by default, this means
> > that these kinds of ratio-based assumptions are even more invalid
> > than they have been.
> >
> > Right now, a zImage doesn't advertise the size of its uncompressed
> > image, but I think with things like CONFIG_DEBUG_RODATA, we can no
> > longer make assumptions like we have done in the past, and we need
> > the zImage to provide this information so that the boot environment
> > can be setup sanely by boot loaders/kexec rather than relying on
> > broken heuristics like this.
> >
> > Thoughts?
> 
> I'm much less familiar with the ARM decompression stub, but is there a
> boot image header (like x86 has)? If not, perhaps we can invent one,
> and it can carry all the details needed for a bootloader to do the
> right things.

Yes, x86 stores addr and size of initrd into boot header. When
decompressing kernel it will choose a safe starting position before the
loaded place according to the max evaluation of decompressing algorithm.

ARM only use a rough 4 times evaluation, sounds too hasty. Simplest way
is to increase times to 8 for now. The final way should be as Kees
suggested.

Thanks
Baoquan
