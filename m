From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed, 02 Dec 2009 18:05:12 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <20091202164930.GG14091@buzzloop.caiaq.de>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<20091202164930.GG14091@buzzloop.caiaq.de>
Message-ID: <4B169E48.2000804@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Daniel Mack wrote:
> On Wed, Dec 02, 2009 at 05:13:01PM +0100, Valentin Longchamp wrote:
>> On various mxc boards, the intial ULPI reads resulted in a timeout
>> which prevented the transceiver to be identified and thus the ehci
>> device to be probed.
>>
>> Initializing the hardware lines connected to the transceiver (through
>> pdata->init call) before actually enabling clocks and configuring
>> registers in the devices fixes this problem.
> 
> Hmm, glad to hear it fixed your problem :) However, there is no real
> ULPI communication done on the viewports before the board specific
> init function is called, and the timeouts that are reported come from
> the transceiver probing which is called at a later point.

Yeah I know, there is no reason why it would help, that's why it seemed 
strange to me too. I tried to have to the same sequence as I have with 
the ISP1504 coupled with the fsl_usb2_udc where I NEVER have a problem 
with the exact same driver and it did the trick (at least for me).

Maybe there is a bad reset or something like this earlier, that causes 
the initializations on the viewport to put the transceiver in a state 
where it cannot answer the probing.
> 
> Even with that patch applied, one board I have here fails to initialize
> the OTG port.

I have not tested it on the OTG port, only on the Host 2 (that's the 
only one I use as host on our hardware).

> 
>> Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
> 
> As it fixes a real world problem and doesn't seem to be harmful to
> anyone else:
> 
> Acked-by: Daniel Mack <daniel@caiaq.de>
> 
>>  drivers/usb/host/ehci-mxc.c |   18 +++++++++---------
>>  1 files changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/usb/host/ehci-mxc.c b/drivers/usb/host/ehci-mxc.c
>> index 35c56f4..689b683 100644
>> --- a/drivers/usb/host/ehci-mxc.c
>> +++ b/drivers/usb/host/ehci-mxc.c
> 
> [...]
> 
>> @@ -192,15 +201,6 @@ static int ehci_mxc_drv_probe(struct platform_device *pdev)
>>  	if (ret < 0)
>>  		goto err_init;
>>  
>> -	/* call platform specific init function */
>> -	if (pdata->init) {
>> -		ret = pdata->init(pdev);
>> -		if (ret) {
>> -			dev_err(dev, "platform init failed\n");
>> -			goto err_init;
>> -		}
>> -	}
>> -
>>  	/* most platforms need some time to settle changed IO settings */
>>  	mdelay(10);
> 
> You should probably also move the mdelay() and the comment then, right?
> And as you're on it, the delay make more sense inside the
> 'if (pdata->init)' block ...

Ok, will do that

> 
> Thanks,
> Daniel
> 

Thanks for the comments and the ack, new version coming soon.

Val

-- 
Valentin Longchamp, PhD Student, EPFL-STI-LSRO1
valentin.longchamp at epfl.ch, Phone: +41216937827
http://people.epfl.ch/valentin.longchamp
MEA3485, Station 9, CH-1015 Lausanne
