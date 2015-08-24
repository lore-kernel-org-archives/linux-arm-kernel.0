From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Aug 2015 14:15:57 +0100
Subject: [PATCH v2 5/5] arm64: add KASan support
In-Reply-To: <CACRpkdYaqK8upK-3b01JbO_y+sHnk4-Hm1MfvjSy0tKUkFREtQ@mail.gmail.com>
References: <1431698344-28054-1-git-send-email-a.ryabinin@samsung.com>
 <1431698344-28054-6-git-send-email-a.ryabinin@samsung.com>
 <CACRpkdaRJJjCXR=vK1M2YhR26JZfGoBB+jcqz8r2MhERfxRzqA@mail.gmail.com>
 <CAPAsAGy-r8Z2N09wKV+e0kLfbwxd-eWK6N5Xajsnqq9jfyWqcQ@mail.gmail.com>
 <CACRpkdZmHLMxosLXjyOPdkavo=UNzmTcHOLF5vV4cS1ULfbq6A@mail.gmail.com>
 <CAPAsAGw-iawTpjJh66rQN5fqBFT6UBZCcv2eKx7JTqCXzhzpsw@mail.gmail.com>
 <CACRpkdY2i2M27gP_fXawkFrC_GFgWaKr5rEn6d47refNPiEk=g@mail.gmail.com>
 <55AE56DB.4040607@samsung.com>
 <CACRpkdYaqK8upK-3b01JbO_y+sHnk4-Hm1MfvjSy0tKUkFREtQ@mail.gmail.com>
Message-ID: <20150824131557.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 21, 2015 at 11:27:56PM +0200, Linus Walleij wrote:
> On Tue, Jul 21, 2015 at 4:27 PM, Andrey Ryabinin <a.ryabinin@samsung.com> wrote:
> 
> > I used vexpress. Anyway, it doesn't matter now, since I have an update
> > with a lot of stuff fixed, and it works on hardware.
> > I still need to do some work on it and tomorrow, probably, I will share.
> 
> Ah awesome. I have a stash of ARM boards so I can test it on a
> range of hardware once you feel it's ready.
> 
> Sorry for pulling stuff out of your hands, people are excited about
> KASan ARM32 as it turns out.

People may be excited about it because it's a new feature, but we really
need to consider whether gobbling up 512MB of userspace for it is a good
idea or not.  There are programs around which like to map large amounts
of memory into their process space, and the more we steal from them, the
more likely these programs are to fail.

The other thing which I'm not happy about is having a 16K allocation per
thread - the 16K allocation for the PGD is already prone to invoking the
OOM killer after memory fragmentation has set in, we don't need another
16K allocation.  We're going from one 16K allocation per process to that
_and_ one 16K allocation per thread.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
