From: arend@broadcom.com (Arend van Spriel)
Date: Sat, 23 Apr 2011 17:07:19 +0200
Subject: [PATCH] drivers: brcmaxi: provide amba axi functionality in
	separate module
In-Reply-To: <BANLkTinUWNvkigqkOQeYsyaAKnVXOCji8w@mail.gmail.com>
References: <1303331669-31293-1-git-send-email-arend@broadcom.com>
	<201104211612.49805.arnd@arndb.de> <op.vuallvn63ri7v4@arend-laptop>
	<BANLkTinUWNvkigqkOQeYsyaAKnVXOCji8w@mail.gmail.com>
Message-ID: <op.vuecahou3ri7v4@arend-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 23 Apr 2011 14:33:21 +0200, Jonas Gorski <jonas.gorski@gmail.com>  
wrote:

> On 21 April 2011 16:38, Arend van Spriel <arend@broadcom.com> wrote:
>> Would it be possible to make chipcommon driver optional (not doing the
>> initialization)?
>
> This would need to be done on a per-device/bus basis, at least for
> embedded. Consider the following setup (which is quite common for dual
> band routers):
>
> BCM4718 (bus A)
   +- MIPS74k
> +- Common Core <- provides flash write access, GPIOs, watchdog, ...
> +- 802.11 Core <- for 2.4Ghz wifi
> +- PCIe Core
>   + BCM43224 (bus B)
>     +- Common Core
>     +- 802.11 Core <- for 5Ghz wifi
>
> (I omitted any cores not relevant for the example)

The MIPS may be relevant as well ;-)

In the example above I would expect two axi bus driver instances for bus A  
and bus B.

> So eventually you want to able to drive both 802.11 cores, but can't
> exclusively claim both common cores.

I would expect to be probed twice. One call for 2.4GHz 802.11 core  
referencing to bus A and one call for 5GHz 802.11 core referencing to bus  
B.

Regarding chipcommon I agree that it requires one init sequence per  
device. I would just like to have the option to provide a custom  
initialization function for chip common (and possibly pcie) somehow.

Gr. AvS
-- 
"The world is indeed comic, but the joke is on mankind." ? H.P. Lovecraft
