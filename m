From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 2 Jul 2018 19:57:57 +0200
Subject: [RFC net-next 08/15] net: lora: sx1276: Add debugfs
In-Reply-To: <20180702162649.GC2737@nanopsycho.orion>
References: <20180701110804.32415-1-afaerber@suse.de>
 <20180701110804.32415-9-afaerber@suse.de>
 <20180702162649.GC2737@nanopsycho.orion>
Message-ID: <d6aa15a0-9660-0687-9da0-53749c1235f8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.07.2018 um 18:26 schrieb Jiri Pirko:
> Sun, Jul 01, 2018 at 01:07:57PM CEST, afaerber at suse.de wrote:
>> Allow some interactive inspection at runtime via debugfs.
>>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
[...]
>> @@ -566,6 +691,10 @@ static int sx1276_probe(struct spi_device *spi)
>> 		return ret;
>> 	}
>>
>> +	priv->debugfs = debugfs_create_dir(dev_name(&spi->dev), NULL);
>> +	debugfs_create_file("state", S_IRUGO, priv->debugfs, netdev, &sx1276_state_fops);
>> +	debugfs_create_file("frequency", S_IRUGO, priv->debugfs, netdev, &sx1276_freq_fops);
> 
> Hmm. These look like useful information not only for debugging. I think
> it would be worth to expose these via some standard uapi. Like generic
> netlink, similar to nl80211

Which API to use for reading/writing such config data was question 4) in
my cover letter. :)

"frequency" was added first and helped me debug a calculation overflow.
Netlink might indeed be an option here, haven't worked on it before,
I'll look into nl80211. Thanks.

"state" was just a partial dump of SPI registers, to monitor status
changes after the initial probe or other callbacks with printks, while
debugging GPIO interrupts iirc. So I'd think merging that to mainline
would be unnecessary, but it could remain useful during development.

Cheers,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
