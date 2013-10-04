From: pwalmsley@nvidia.com (Paul Walmsley)
Date: Fri, 4 Oct 2013 00:08:36 -0700
Subject: Tegra baseline test results for v3.12-rc1
In-Reply-To: <alpine.DEB.2.02.1309230703090.18475@utopia.booyaka.com>
References: <A4DCC42E2B5835498682FCB0A8F9F873378C267FFD@HQMAIL04.nvidia.com>
 <CAOesGMjAQZMUdC9ZoGhX=zEA3HCky1zwE0-B6fNAJubqO9bVzw@mail.gmail.com>
 <alpine.DEB.2.02.1309230703090.18475@utopia.booyaka.com>
Message-ID: <524E6974.4040001@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

On 09/23/2013 12:26 AM, Paul Walmsley wrote:
> On Wed, 18 Sep 2013, Olof Johansson wrote:
>
>> On Wed, Sep 18, 2013 at 9:23 AM, Paul Walmsley <pwalmsley@nvidia.com> wrote:
>>
>>> vmlinux object size
>>> (delta in bytes from test_v3.11-rc7 (d8dfad3876e4386666b759da3c833d62fb8b2267)):
>>>     text     data      bss    total  kernel
>>>   -89208   +10000     -416   -79624  multi_v7_defconfig
>>> +299303    +7244    +1484  +308031  tegra_defconfig
>>>
>> Hm. These deltas are huge. :(  It would be interesting to know where
>> they come from.
>

As far as the tegra_defconfig build size deltas go, the short story is:

+ 110KB from v3.11-rc7 to v3.12-rc1, using the same v3.11-rc7 
tegra_defconfig
+ 99KB after CONFIG_USB_XHCI_HCD=y
+ 51KB when the various CONFIG_PCI* changes are added
+ 36KB after CONFIG_SYSVIPC=y
+ 10KB after CONFIG_MOUSE_PS2_ELANTECH=y

Details below.

Still need to look into the boot memory size differences.


- Paul



A. v3.11-rc7:
    text       data        bss        dec        hex filename
7996434     359300     350288    8706022     84d7e6 vmlinux

B. v3.12-rc1 with the v3.11-rc7 tegra_defconfig + 'make oldnoconfig':
    text       data        bss        dec        hex filename
8101095     364096     351580    8816771     868883 vmlinux      (+110KB 
from [A])

C. As [B] above, but with CONFIG_USB_XHCI_HCD=y:
    text       data        bss        dec        hex filename
8199739     364224     351580    8915543     880a57 vmlinux      (+209KB 
from [A])

D. As [C] above, but with CONFIG_PCI_TEGRA=y:
    text       data        bss        dec        hex filename
8207431     364288     351580    8923299     8828a3 vmlinux      (+217KB 
from [A])

E. As [D] above, but with CONFIG_PCIEPORTBUS=y + related defaults:
    text       data        bss        dec        hex filename
8233007     364856     351644    8949507     888f03 vmlinux      (+243KB 
from [A])

F. As [E] above, but with CONFIG_PCI_MSI=y:
    text       data        bss        dec        hex filename
8249233     365128     351644    8966005     88cf75 vmlinux      (+260KB 
from [A])

G. As [F] above, but with CONFIG_DMA_CMA=y + related defaults:
    text       data        bss        dec        hex filename
8251161     365184     351772    8968117     88d7b5 vmlinux      (+262KB 
from [A])

H. As [G] above, but with CONFIG_SYSVIPC=y:
    text       data        bss        dec        hex filename
8286273     365968     351772    9004013     8963ed vmlinux      (+298KB 
from [A])

I. As [H] above, but with CONFIG_MOUSE_PS2_ELANTECH=y:
    text       data        bss        dec        hex filename
8295737     366544     351772    9014053     898b25 vmlinux      (+308KB 
from [A])
