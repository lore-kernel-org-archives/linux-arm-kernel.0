From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 18 Nov 2014 11:19:13 +0100
Subject: [PATCH 3/4] simplefb: Change simplefb_init from module_init to
 fs_initcall
In-Reply-To: <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
 <20141113085238.GE20972@lukather>
 <CAMuHMdXZ4V4GHvyDLOP8FYvPuGArc5G0aO6NCE9FKHT24YRGPg@mail.gmail.com>
Message-ID: <20141118101911.GA15769@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 13, 2014 at 09:58:41AM +0100, Geert Uytterhoeven wrote:
> Hi Maxime,
> 
> On Thu, Nov 13, 2014 at 9:52 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> >> -module_init(simplefb_init);
> >> +/*
> >> + * While this can be a module, if builtin it's most likely the console
> >> + * So let's leave module_exit but move module_init to an earlier place
> >> + */
> >
> > Not really related to this patch itself, but do we want to support
> > simplefb as a module? It seems like it's going to be most of the time
> > broken.
> 
> If it depends on clocks, it won't work as a module, as CCF will have disabled
> all unused clocks at that point.

If it does depend on anything beyond clocks it won't work at all. Clocks
are special because they get set up very early at boot time. If it turns
out that a simplefb ever needs a regulator to remain on, and that's even
quite likely to happen eventually, it's going to fail miserably, because
those regulators will typically be provided by a PMIC on an I2C bus. The
regulator won't be registered until very late into the boot process and
a regulator_get() call will almost certainly cause the simplefb driver
to defer probing.

Now deferring probing is a real showstopper for simplefb, because not
only does it make the framebuffer useless as early boot console, once
probing is attempted again the clocks that it would have needed to
acquire to keep going will already have been switched off, too.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141118/bc68db5b/attachment.sig>
