From: troy.kisky@boundarydevices.com (Troy Kisky)
Date: Tue, 29 Jan 2013 11:46:40 -0700
Subject: i.Mx6Quad - eth0: tx queue full!
In-Reply-To: <5107FA00.2010809@gmail.com>
References: <5106B7EE.3040603@gmail.com>
 <5106D5D4.2090200@boundarydevices.com> <5107FA00.2010809@gmail.com>
Message-ID: <51081910.4030707@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2013 9:34 AM, Vikram Narayanan wrote:
> On 1/29/2013 1:17 AM, Troy Kisky wrote:
>> On 1/28/2013 10:39 AM, Vikram Narayanan wrote:
>>> Running the latest head <linux-2.6.git> on an i.Mx6Quad based platform
>>> gives me the below error when flooded with ping requests.
>>>
>>> == Start log ==
>>> [ 2555.004031] ------------[ cut here ]------------
>>> [ 2555.009740] WARNING: at net/sched/sch_generic.c:254
>>> dev_watchdog+0x298/0x2b8()
>>> [ 2555.018721] NETDEV WATCHDOG: eth0 (fec): transmit queue 0 timed out
>>
>> I think the tx interrupt status bit was lost. The packets were
>> transmitted, but the interrupt never
>> happened. The controller should have been reset here, but perhaps a bug
>> with the reset code.
>> Are you using the mainline kernel, or a version Freescale's kernel.
>
> I tried with both the kernels. Freescale's and mainline results in the 
> same error.
>
>> mainline fec_restart does not reset tx_full
>>
>> You can try adding
>> fep->tx_full = 0;
>
> With this there was no improvement.

I have fixed this bug (and more) on Freescale's kernel 
(imx-3.0.35_1.1.0). I created a branch you can try.
Feel free to port to mainline.

This is the patch that should fix your problem
fec: clear TX_FULL in fec_restart

git://github.com/boundarydevices/linux-imx6.git ethernet_test



Please let me know results.
Thanks
Troy
