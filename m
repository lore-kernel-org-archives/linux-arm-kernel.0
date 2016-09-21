From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Wed, 21 Sep 2016 10:56:14 +0300
Subject: =?UTF-8?B?UmU6IFt2MTIsIDcvOF0gYmFzZTogc29jOiBpbnRyb2R1Y2Ugc29jX2Rldmlj?=
 =?UTF-8?B?ZV9tYXRjaCgpIGludGVyZmFjZQ==?=
In-Reply-To: <1474441040-11946-8-git-send-email-yangbo.lu@nxp.com>
References: <1474441040-11946-1-git-send-email-yangbo.lu@nxp.com>
 <1474441040-11946-8-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1474444574.270880035@f136.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>?????, 21 ???????? 2016, 9:57 +03:00 ?? Yangbo Lu <yangbo.lu@nxp.com>:
>
>From: Arnd Bergmann < arnd@arndb.de >
>
>We keep running into cases where device drivers want to know the exact
>version of the a SoC they are currently running on. In the past, this has
>usually been done through a vendor specific API that can be called by a
>driver, or by directly accessing some kind of version register that is
>not part of the device itself but that belongs to a global register area
>of the chip.
...
>+const struct soc_device_attribute *soc_device_match(
>+const struct soc_device_attribute *matches)
>+{
>+int ret = 0;
>+
>+if (!matches)
>+return NULL;
>+
>+while (!ret) {
>+if (!(matches->machine || matches->family ||
>+      matches->revision || matches->soc_id))
>+break;
>+ret = bus_for_each_dev(&soc_bus_type, NULL, (void *)matches,
>+       soc_device_match_one);
>+if (!ret)
>+matches++;

So, what happen if next "matches" (after increment) will be NULL?

I think you should use while(matches) at the start of this procedure.

---
