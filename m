From: ccross@android.com (Colin Cross)
Date: Tue, 16 Nov 2010 19:55:59 -0800
Subject: [PATCH] [ARM] twd: Allow twd rescaling to match cpu frequency
In-Reply-To: <2D4BBBBAD3C3714F8E8675F927E908210A210908@ESESSCMS0361.eemea.ericsson.se>
References: <1283396674-4865-1-git-send-email-ccross@android.com>
	<AANLkTinsRCinLdhq1xj0tx09Jb=Tohdbd7PUD=ae1q3m@mail.gmail.com>
	<DB5ED9F94071134F8D813944A461CF1A0196031CBA@ESESSCMS0361.eemea.ericsson.se>
	<20101112125901.GA3619@n2100.arm.linux.org.uk>
	<2D4BBBBAD3C3714F8E8675F927E908210A210908@ESESSCMS0361.eemea.ericsson.se>
Message-ID: <AANLkTikZhikQ+Ag8++NpMn5vWPmTkeEmVCE6s5TCfdGr@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 12, 2010 at 5:05 AM, Harald Gustafsson
<harald.gustafsson@ericsson.com> wrote:
>> > Don't forget the other patches to make this work:
>> >
>> > [ARM] twd: Always calibrate local timer [ARM] twd: Fix updating
>> > control register in set_mode [ARM] twd: Fix prescaler
>> getting cleared
>> > by set_mode
>>
>> ... which have never been posted to this mailing list, so no
>> one here knows of them.
>
> They are on the tegra branch git also authored by Colin. So I would suggest that Colin make all the changes into a new patch.
>
> http://android.git.kernel.org/?p=kernel%2Ftegra.git&a=search&h=refs%2Fheads%2Flinux-tegra-2.6.35&st=commit&s=twd
>
> /Harald

I'm not happy with the current implementation, which is why it hasn't
been posted.  I'm planning to rewrite it with cpufreq notifiers, but
that brings us back to the periphclk divider problem discussed in
http://comments.gmane.org/gmane.linux.ports.arm.kernel/91827

If the frequency is going to change, using clk_get_rate on periphclk
is not sufficient, because the clock will not have been updated when
the prechange cpufreq notifier is called.  If the cpu frequency is
increasing, the twd divider must be recalculated before the frequency
changes to avoid timers expiring early.  Either the clock used by the
twd driver must be updated before prechange notifiers and after
postchange notifiers, which is difficult to fit in to all the
different implementations of the clock api, or the twd driver needs to
know the ratio between the cpu frequency and the periphclk frequency.
