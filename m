From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Oct 2016 22:01:38 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <20161005204452.GB26721@remoulade>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
 <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
 <CAKdL+dQH=9C2aGf7ys5-vXM7pkdPYUQ8xYWLipwVbABOz09f1g@mail.gmail.com>
 <20161005204452.GB26721@remoulade>
Message-ID: <20161005210137.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 09:44:53PM +0100, Mark Rutland wrote:
> The zeroing case is similar to the restartable sequences design. So that's
> probably worth looking into.

You're sending mixed messages: in your previous message, you said:

  Arguably, someone could have (ab)used TPIDRURW between commits 6a1c531
  and a4780ad to detect context switches, but in practice they don't
  appear to have, and we know of an established user relying on the
  current behaviour.

  For better or worse, the current behaviour is ABI.

Now you're suggesting that we could go back to the case where the
register is zeroed.

Well, the fact is that we _can_ change the TPIDRURW behaviour - we just
need to be careful about how we change it.  Eg, we _could_ introduce a
per-process flag which indicates that we want some other behaviour from
TPIDRURW such as zeroing it on context switches.  The default would be
to preserve the existing behaviour as doing anything else breaks
existing programs.  The problem there is finding an acceptable way to
control such a flag from userspace (eg, prctl, syscall, etc).

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
