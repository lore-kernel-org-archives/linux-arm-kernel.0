From: andy@warmcat.com (Andy Green)
Date: Fri, 18 Mar 2011 08:49:59 +0000
Subject: [RFC PATCH 2/5] OMAP2+: add cpu id register to MAC address helper
In-Reply-To: <201103180934.39997.arnd@arndb.de>
References: <20110312224440.27728.60593.stgit@otae.warmcat.com>
	<20110312225047.27728.1835.stgit@otae.warmcat.com>
	<201103180934.39997.arnd@arndb.de>
Message-ID: <4D831CB7.7060509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2011 08:34 AM, Somebody in the thread at some point said:

>> +void omap2_die_id_to_mac(u8 *mac, int length)
>> +{
>> +       struct omap_die_id odi;
>> +
>> +       omap_get_die_id(&odi);
>> +       memcpy(mac,&odi.id_0, length);
>> +
>> +       /* mark it as not multicast and outside official 80211 MAC namespace */
>> +
>> +       mac[0] = (mac[0]&  ~1) | 2;
>> +}
>
> This is a pretty clever trick, but it's not an official globally unique MAC
> address, right? Maybe we can ask TI to officially request a MAC address range
> for OMAP SoCs and document an official procedure to compute it.

This was an idea from Loic Minier.  80211 allows local namespace MACs, 
this one is marked up as such, so it is as OK as the CPU ID bits are 
reasonably well distributed in terms of collision.

You are right though the overall correct solution from the board side is 
to have paid for two (WLAN has the same problem -- worse right now it 
comes up with 00:00:00:00:00:00) proper namespace MACs.  That's still 
not enough because there must be somewhere on the board to store it, I 
call this "board identity" storage, and there is nowhere on Panda.  If 
you put it on SD card, it has the effect that your MAC address moves 
with the SD card between boards which is less than ideal, you have to 
make sure if he rewrites his SD card somehow it knows to use the right 
mac address... it's not credible.

The problem with what you suggested is that CPU ID is just a static 
token chosen arbitrarily by TI in the factory so you can't somehow 
"compute" the MAC which is assigned by IEEE, which is also an arbitrary 
range chosen by them, from the unrelated CPU ID content.

It is interesting to use CPU ID though because it will not vary 
per-board.  So this is why the patch arrives at what it is doing using 
the legal private namespace concept.

-Andy
