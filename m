From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Oct 2014 18:36:01 +0100
Subject: [PATCHv8 1/2] pwm: Add Allwinner SoC support
In-Reply-To: <20141020170603.GG10616@piout.net>
References: <1413743305-1979-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1413743305-1979-2-git-send-email-alexandre.belloni@free-electrons.com>
 <54442BB1.1080403@mleia.com> <20141020102939.GB10616@piout.net>
 <544509C7.9010309@mleia.com> <20141020170603.GG10616@piout.net>
Message-ID: <20141020173601.GX27405@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 07:06:04PM +0200, Alexandre Belloni wrote:
> Because the PWM is getting configured from either a kernel thread or a
> userspace thread accessing /sys. So you probably want the current thread
> to sleep so the other thread accessing the register can finish. Unless
> you are on smp and then, the mutex will spin for some time and your
> other cpu will be finished by then.

I agree with Vladimir.  A spinlock would be better here.  You're only
needing to sleep for a short time (the time it takes to complete the
register accesses) and to have a competing thread go through a context
switch twice is stupidly expensive compared to having it wait a short
time for the spinlock to be released.

What the driver could do with is using the relaxed IO accessors too,
if you care about eliminating the unnecessary barriers in there.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
