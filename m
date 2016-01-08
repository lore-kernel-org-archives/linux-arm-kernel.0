From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 8 Jan 2016 15:06:18 +0000
Subject: range operation of outer cache when start >= end?
In-Reply-To: <CAK7LNATi5CE3Uc5UgQ6OncC5b=bDavAyNfqi_nqvcVkOrbFhRQ@mail.gmail.com>
References: <CAK7LNATi5CE3Uc5UgQ6OncC5b=bDavAyNfqi_nqvcVkOrbFhRQ@mail.gmail.com>
Message-ID: <20160108150618.GL19062@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 08, 2016 at 11:54:30AM +0900, Masahiro Yamada wrote:
> I know I am nitpicking.  Forgive me if I am asking a silly question.
> 
> 
> How should the outer-cache handle such an insane case like  start >= end?

Passing start >= end isn't defined, code should not pass start >= end.

> Assumed answers are:
> 
> [1] Do not care about that.  It should never happen.  If it does, fix
> the caller.

This applies.  What situation are you seeing start >= end?

What you will get with the existing code is potentially some cache
cleaning and a sync, but nothing apart from that.  __l2c210_op_pa_range()
becomes a no-op of start >= end.  However, that behaviour is not
guaranteed.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
