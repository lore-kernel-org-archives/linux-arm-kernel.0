From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Dec 2010 16:12:13 +0000
Subject: [PATCH] MTD: m25p80: add debugging trace in sst_write()
In-Reply-To: <4D08C1C8.3090100@ru.mvista.com>
References: <1292414372-17085-1-git-send-email-nicolas.ferre@atmel.com>
	<4D08C1C8.3090100@ru.mvista.com>
Message-ID: <20101215161213.GC9937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 04:25:28PM +0300, Sergei Shtylyov wrote:
>> +	DEBUG(MTD_DEBUG_LEVEL2, "%s: %s %s 0x%08x, len %zd\n",
>> +			dev_name(&flash->spi->dev), __func__, "to",
>
>    What's the point of printing "to" as variable? :-)

One valid reason to do this is if you have several formatting strings
all the same.  GCC can merge identical strings together.

So, if you have:

 "%s: %s %s 0x%08x, len %zd", dev_name(), __func__, "to"
 "%s: %s %s 0x%08x, len %zd", dev_name(), __func__, "from"
 "%s: %s %s 0x%08x, len %zd", dev_name(), __func__, "foo"

Then you end up with one long string and three short strings instead of

 "%s: %s to 0x%08x, len %zd", dev_name(), __func__
 "%s: %s from 0x%08x, len %zd", dev_name(), __func__
 "%s: %s foo 0x%08x, len %zd", dev_name(), __func__

which'd be three long strings.
