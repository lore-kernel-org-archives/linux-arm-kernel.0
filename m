From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 13 May 2014 17:18:57 +0200
Subject: [PATCHv3] C_CAN: hwinit support for non-TI devices
In-Reply-To: <20140513150857.GA11608@amd.pavel.ucw.cz>
References: <CAF03EBf9KXqB4W9GuDduhLwp_kwFjUEi3syU7fX3KpXfZEFxHg@mail.gmail.com>
 <CAF03EBd19PC5RAsLR6-dMPF2x3XRf9X4bFPgX2kRdCYWUQBYcA@mail.gmail.com>
 <20140430215359.GA15148@amd.pavel.ucw.cz>
 <CAF03EBewoV0pOOmNQBwPrKgm-zhaSbFcNd_UiEhFWyUrq91-Jg@mail.gmail.com>
 <20140502084851.GA5730@amd.pavel.ucw.cz>
 <20140505120801.GA16461@amd.pavel.ucw.cz>
 <20140506135702.GA9879@amd.pavel.ucw.cz> <5370ED11.4000002@pengutronix.de>
 <20140513130914.GA9806@amd.pavel.ucw.cz> <53721FD5.50508@pengutronix.de>
 <20140513150857.GA11608@amd.pavel.ucw.cz>
Message-ID: <537237E1.4000505@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13/2014 05:08 PM, Pavel Machek wrote:
> Hi!
> 
> 
> On Tue 2014-05-13 15:36:21, Marc Kleine-Budde wrote:
>> On 05/13/2014 03:09 PM, Pavel Machek wrote:
>>> Non-TI chips (including socfpga) needs different raminit
>>> sequence. Implement it.
>>>
>>> const's in the hwinit prototype forced me to add const to more
>>> prototypes. This makes changes bigger but the result is cleaner.
>>
>> Why not split into several patches?
>>
>>> Unfortunately, testing-c_can does not boot on sockit, but previous
>>> version of patch was tested by me and Thor Thayer.
>>
>> Have a look at:
>>
>>     git at gitorious.org:linux-can/linux-can-next.git
>> testing-c_can-based-on-net
> 
> git fetch git at gitorious.org:linux-can/linux-can-next.git
> testing-c_can-based-on-net:testing-c_can-based-on-net
> The authenticity of host 'gitorious.org (87.238.52.168)' can't be
> established.
> RSA key fingerprint is
> 7e:af:8d:ec:f0:39:5e:ba:52:16:ce:19:fa:d4:b8:7d.
> 
> But I was able to
> 
> git fetch git://gitorious.org/linux-can/linux-can-next.git
> testing-c_can-based-on-net:testing-c_can-based-on-net 

Sorry, I copied the wrong URL.

>> This branch uses net/master as it's base, I've split your patch into 3,
>> and squashed the 32bit-const changes into the 32-bit access patch. The
>> remaining patch looks quite clean.
> 
> Thanks a lot!
> 
>> Can you please test the branch, I hope it boots on sockit.
> 
> That one still dies early in boot, but I was able to apply some
> changes from my main tree (not CAN related) and get it to boot.

\o/

> And yes, it seems to work:
> 
> [It still does not contain some "interesting" changes from altera
> tree, but as I could not get explanation why they are needed -- and
> they don't seem to be needed -- maybe it is better that way.]

Are there changes to the CAN driver or the SoC infrastructure?

> root at sockit:~# uname -a
> Linux sockit 3.15.0-rc4-00470-g4477be8-dirty #99 SMP Tue May 13
> 17:02:02 CEST 2014 armv7l GNU/Linux
> root at sockit:~# ip link set can0 up type can bitrate 125000 loopback on
> c_can_platform ffc00000.d_can can0: setting BTR=1c31 BRPE=0000
> root at sockit:~# ifconfig can0 up
> root at sockit:~# candump can0 &
> root at sockit:~# cansend can0 "123#DEADBEEF"
>   can0  123   [4]  DE AD BE EF
>   can0  123   [4]  DE AD BE EF
> root at sockit:~# cansend can0 "123#DEADBEEF"
>   can0  123   [4]  DE AD BE EF
>   can0  123   [4]  DE AD BE EF

\o/

Thanks for testing.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140513/79e2386c/attachment-0001.sig>
