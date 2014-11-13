From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 13 Nov 2014 11:42:03 +0100
Subject: [PATCH 3/4] simplefb: Change simplefb_init from module_init to
 fs_initcall
In-Reply-To: <CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather> <546478B5.2040002@redhat.com>
 <CACxGe6u8B854PEWw8XzwhyX8joMWwOsHOOXtmBmC1TgCGjGtdg@mail.gmail.com>
Message-ID: <20141113104203.GF20972@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 10:29:52AM +0000, Grant Likely wrote:
> On Thu, Nov 13, 2014 at 9:24 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> > On 11/13/2014 09:52 AM, Maxime Ripard wrote:
> >>> +/*
> >>> + * While this can be a module, if builtin it's most likely the console
> >>> + * So let's leave module_exit but move module_init to an earlier place
> >>> + */
> >>
> >> Not really related to this patch itself, but do we want to support
> >> simplefb as a module? It seems like it's going to be most of the time
> >> broken.
> >
> > A valid point, my mean reasoning here is that some may see not being able to
> > use it as a module as a regression, so I just kept things as is, but I do
> > agree that it is advisable to just build it in.
> 
> Like a lot of things, if it is made a modules, and it breaks for the
> user, the user gets to keep the pieces. There are potentially some
> valid scenarios where it is fine to have it as a module. I don't
> recommend changing this unless is actually starts causing problems.

I don't really agree here. If it's broken because the clocks, reset,
memory, or whatever resource has been reclaimed by the kernel before
the module even had a chance to probe, the only thing that the user
will get is that there's no chance it's ever going to work, and that
it's just unreliable.

If we know that it's going to break, and that there's no way it can be
reliable (as in on all the SoCs reliable), keeping it as a module is
just asking for trouble.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/27f6b3c0/attachment-0001.sig>
