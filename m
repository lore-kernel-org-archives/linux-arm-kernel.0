From: grinberg@compulab.co.il (Igor Grinberg)
Date: Wed, 14 Dec 2011 17:10:10 +0200
Subject: serial tty name
In-Reply-To: <20111214144344.GA2090@richard-laptop>
References: <20111214144344.GA2090@richard-laptop>
Message-ID: <4EE8BC52.5060905@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 12/14/11 16:43, Richard Zhao wrote:
> How to map different uart port to ttymxc0 (take imx for example)?
> 
> In rootfs, it usually "getty ttymxc0"  to get
> serial console. And the rootfs may be shared by different boards.
> Traditionaly way is to set right platform device ID.
> 
> But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> always needs to modify the getty command when your change another board.
> 
> Is there a way to fix it?

As for fix in userspace, you can spawn getty on every ttymxc*,
so you will get it always.

Another (userspace) fix would be:
Instead of getty, add a script (say getty.sh) which will do something like:
-----------
CONSOLE=`cat /proc/cmdline | tr " " "\n" | grep console= | tr "=" " " | tr "," " "`
TTY=`echo $CONSOLE | cut -d' ' -f 2`
SPEED=`echo $CONSOLE | cut -d' ' -f 3`

/sbin/getty -L $TTY $SPEED vt100
--------------

I use the above, because I have not just multiple boards,
but multiple platforms each with its own tty name...

-- 
Regards,
Igor.
