From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Nov 2015 22:39:04 +0000
Subject: [PATCH v2 2/2] arm: mm: support ARCH_MMAP_RND_BITS.
In-Reply-To: <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
References: <1446574204-15567-1-git-send-email-dcashman@android.com>
 <1446574204-15567-2-git-send-email-dcashman@android.com>
 <CAGXu5jKGzDD9WVQnMTT2EfupZtjpdcASUpx-3npLAB-FctLodA@mail.gmail.com>
Message-ID: <20151103223904.GG8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 03, 2015 at 11:19:44AM -0800, Kees Cook wrote:
> On Tue, Nov 3, 2015 at 10:10 AM, Daniel Cashman <dcashman@android.com> wrote:
> > From: dcashman <dcashman@google.com>
> >
> > arm: arch_mmap_rnd() uses a hard-code value of 8 to generate the
> > random offset for the mmap base address.  This value represents a
> > compromise between increased ASLR effectiveness and avoiding
> > address-space fragmentation. Replace it with a Kconfig option, which
> > is sensibly bounded, so that platform developers may choose where to
> > place this compromise. Keep 8 as the minimum acceptable value.
> >
> > Signed-off-by: Daniel Cashman <dcashman@google.com>
> 
> Acked-by: Kees Cook <keescook@chromium.org>
> 
> Russell, if you don't see any problems here, it might make sense not
> to put this through the ARM patch tracker since it depends on the 1/2,
> and I think x86 and arm64 (and possibly other arch) changes are coming
> too.

Yes, it looks sane, though I do wonder whether there should also be
a Kconfig option to allow archtectures to specify the default, instead
of the default always being the minimum randomisation.  I can see scope
to safely pushing our mmap randomness default to 12, especially on 3GB
setups, as we already have 11 bits of randomness on the sigpage and if
enabled, 13 bits on the heap.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
