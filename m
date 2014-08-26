From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Aug 2014 19:28:16 +0100
Subject: Generic communication of boot loader state to the OS
In-Reply-To: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
References: <CAKON4Oz-PRgXyNKj=T9ymzOOhCMPjBMdYdE1Mr1CHWv3boskiw@mail.gmail.com>
Message-ID: <20140826182816.GW30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 12:10:00PM -0400, jonsmirl at gmail.com wrote:
> As a side effect this will eliminate the need for kernel command line
> parameters describing boot state. Like console="". Over time it might
> even be able to pass a DHCP IP address from uboot into the kernel.

Err no.  Don't even think about that.  DHCP may be wonderful and all,
but there's a fundamental issue with it: entries time out unless they
are renewed.

Why is that a problem?  Well, take a DHCP server which hands out
dynamic addresses, and updates the DNS.  When the lease expires, it
tears down the DNS entry.

Now take a target booting using DHCP in uboot, which then mounts its
root NFS.  If it tries to startup a DHCP client, the first thing the
DHCP client does is to clean up the interface... resulting in it
killing the root NFS connection.  If that doesn't happen, then you
end up with a problem at shutdown, because DHCP clients always
deconfigure the interface when they're killed off - resulting in
"reboot" not being functional.

Here, I run exactly that setup, and I have found that ubuntu suffers
quite a bit from problems if you don't tell it to keep its fingers
off the ethernet device configuration when running root-NFS - and
believe me, when I'm working on something, I probably do several
tens of remote reboots of targets via "reboot" - I know I've done
about fifty today so far (many of them having to resort to the reset
button because the kernel seems to be locking up rather than rebooting
at the final stage.)

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
