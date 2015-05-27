From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Wed, 27 May 2015 11:44:59 +0200
Subject: sdhci(imx6): misbehaves while installing debian jessie, "Got data
 interrupt 0x00100000"
In-Reply-To: <20150526150122.GP2067@n2100.arm.linux.org.uk>
References: <20150519222320.GM2067@n2100.arm.linux.org.uk>
 <CAPDyKFqR3NwBd9O40BPzHG7Y4wyyJwgdB4NsA_GUO=YEyqFSXQ@mail.gmail.com>
 <20150526150122.GP2067@n2100.arm.linux.org.uk>
Message-ID: <CAPDyKFp57ucUa5r+6RW1hDS2tci+xerc27ga5eoSwO6Wq57gig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

>> Though, the side-effect you are describing isn't very nice. Even if it
>> doesn't solve you problem, perhaps we should discuss about converting
>> from wait_for_completion() to wait_for_completion_timeout(), when the
>> mmc core waits for the host driver to return the result for the
>> request.
>>
>> I guess the tricky part is to find a decent value for the "timeout".
>
> There's two issues which would need solving for that:
>
> 1. The only sane timeout is one which will never trigger under normal
>    operating circumstances, and abnormal load conditions.

Perhaps we could have the timeout calculated per request?

By using the current bus-speed and bus-width we can calculate the
available bandwidth. Obviously we need to also account for overhead
both at host and card side. Probably that overhead is taken from "best
guesses", not sure.

Finally considering the amount of data for the request, we can
calculate a value for the timeout.

>
> 2. When the timeout occurs, the core would need some way to reset the
>    host driver back to a sane state before retrying the command.

Yep. I guess adding a host_ops->abort() callback or similar would be needed.

>
> However, the better question to ask is what's causing this.  It seemed
> to lock up at the same point in the installation - after the base system
> had been installed, but while it was installing additional stuff (for
> xfce.)  From what I remember, it was exactly the same package that the
> MMC host failed at.
>
> I suppose it's entirely possible that the Debian install is running
> some package scripts which end up poking about in memory, which are
> screwing up the MMC host - nothing would surprise me... the Debian
> Jessie install is screwed in other ways (if you select Gnome instead,
> the installer aborts because it discovers that the distro packages
> are missing some dependencies, though I had put that down to the UK
> mirror possibly being out of date...)
>

Kind regards
Uffe
