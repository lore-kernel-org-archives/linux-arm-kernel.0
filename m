From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Sep 2014 15:49:04 +0200
Subject: [PATCH v2] mfd: syscon: Decouple syscon interface from platform
 devices
In-Reply-To: <20140903151611.260a7218@bbrezillon>
References: <1409668935-10667-1-git-send-email-pankaj.dubey@samsung.com>
 <6034841.GFrG3XCMdb@wuerfel> <20140903151611.260a7218@bbrezillon>
Message-ID: <4224773.hl3QDeILqz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 September 2014 15:16:11 Boris BREZILLON wrote:
> I checked that part, and it appears most of the code is already there
> (see usage of regmap_attach_dev function here [1]).
> 
> The only problem I see is that errors are still printed with dev_err,
> which, AFAIK, will trigger a kernel panic if dev is NULL.

Actually not:

static int __dev_printk(const char *level, const struct device *dev,
                        struct va_format *vaf)
{
        if (!dev)
                return printk("%s(NULL device *): %pV", level, vaf);

        return dev_printk_emit(level[1] - '0', dev,
                               "%s %s: %pV",
                               dev_driver_string(dev), dev_name(dev), vaf);
}


	Arnd
