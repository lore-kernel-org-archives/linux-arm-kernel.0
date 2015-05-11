From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 May 2015 20:53:49 +0200
Subject: [linux-sunxi] Re: [PATCH v2 04/13] musb: Do not use
 musb_read[b|w] / _write[b|w] wrappers in generic fifo functions
In-Reply-To: <5550F174.6000709@redhat.com>
References: <1426878682-14521-1-git-send-email-hdegoede@redhat.com>
 <20150511155846.GH19476@saruman.tx.rr.com> <5550F174.6000709@redhat.com>
Message-ID: <10106387.CZmapdhaD3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 May 2015 20:14:12 Hans de Goede wrote:
> Also note, that as I've tried to explain in the commit message already this commit
> makes no functional changes what so ever, the generic musb_default_read/write_fifo
> functions are only used by musb platforms which do not overwrite musb_write* /
> musb_read* and musb_write* / musb_read* are already just thin wrappers around
> the __raw_* functions.

Oh, that's a bit odd:  That would mean that the defaults are also broken on
big-endian platforms, and fixing them would introduce the bug here, unless your
patch is applied.

Any idea why musb uses the __raw_* functions to start with? Can we change
them to read?_relaxed()/write?_relaxed() now that those are available on
all architectures?

	Arnd
