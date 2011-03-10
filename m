From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 10 Mar 2011 17:05:56 +0100
Subject: [RFC PATCHv1 1/2] Export SoC info through sysfs
In-Reply-To: <201103101523.27181.arnd@arndb.de>
References: <1299689961-5028-1-git-send-email-maxime.coquelin-nonst@stericsson.com>
	<201103092058.34236.arnd@arndb.de>
	<AANLkTikFCAC-hdv0Q_9eQs31XHHEc4wYqRjfY0S=FYcz@mail.gmail.com>
	<201103101523.27181.arnd@arndb.de>
Message-ID: <AANLkTinCCZE5hPC+L6_Uw9UTZekzkTGpW5xxBfzTYa7b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 10, 2011 at 3:23 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 10 March 2011, Linus Walleij wrote:
>> So platform is just the platform bus, not the, you know,
>> *platform*. There are competing on-chip busses not just one.
>
> Good point. Note that I did not mean to put the attributes
> directly under /sys/platform/, but under /sys/platform/foo/,
> where foo is the main bus that is used between the CPU core
> and all the SOC components.
>
> This may of course not be easy. If you have an AMBA or PCI
> bus, you might want to have it represented as
> /sys/devices/pci0 and /sys/devices/amba0 instead of
> /sys/devices/platform/foo/amba0/.

Userspace app doing something needs the name and some
unique number to be looked up. The first iteration of this
patch (for the OMAPs) put it in /proc/socinfo with all the
expected fuzz that this should go into sysfs as result.

So: where do we suggest Maxime actually put this then?

> Making up a pseudo-device that does not refer to any hardware
> in particular is against the 'devices are only "devices"'
> rule in Documentation/sysfs-rules.txt.

Fine then I think we agree this can not realistically be
under /sys/devices/* unless we first refactor all platforms
that want to use this mechanism to have top-level-devices.

> If you really want that, it should be in /sys/kernel/,
> /sys/firmware/ or a new top-level directory in sysfs.
>
> I think putting it in /sys/devices is good, but it has
> to be an attribute of an actual device, not an empty
> one that does not even have any child devices. If the
> device represents the soc, then every other device
> that is found in the soc should be a child of this one.

IMO this is not good for socinfo, what is good for apps that
want socinfo is to just attempt to open+read these file paths.
Not to invoke libsysfs and start parsing the file tree to see if
they can find some socinfo somewhere.

What about we just put it in
/sys/socinfo/* then, and we have a simple,
easy-to-understand way for apps that want socinfo to
read it out?

Everyone happy with this?

Yours,
Linus Walleij
