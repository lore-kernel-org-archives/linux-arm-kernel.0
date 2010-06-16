From: viresh.kumar@st.com (Viresh KUMAR)
Date: Wed, 16 Jun 2010 09:29:24 +0530
Subject: [PATCH 06/13] DMAENGINE: driver for the ARM PL080/PL081 PrimeCells
In-Reply-To: <CEE6BB42CAD6E947908279175AF8470A025E5AE1ED@EXDCVYMBSTM006.EQ1STM.local>
References: <1276270031-1607-1-git-send-email-linus.walleij@stericsson.com>	<4C15C60E.6080404@st.com>
	<AANLkTim9n-p-Pw6FWvzQMBiAuB3h9ILq1Ya6XWk_0l-c@mail.gmail.com>
	<4C170EE2.4010706@st.com>
	<CEE6BB42CAD6E947908279175AF8470A025E5AE1ED@EXDCVYMBSTM006.EQ1STM.local>
Message-ID: <4C184C1C.4000204@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/16/2010 1:44 AM, Linus WALLEIJ wrote:
> [Viresh]
> 
>> On 6/14/2010 7:09 PM, Linus Walleij wrote:
>> I have few more doubts that i wanted to ask. Are following supported in
>> your
>> driver, we need them in SPEAr:
>>  - Configure burst size of source or destination.
> 
> The PrimeCell extension supports this, do you need that in things
> that are not PrimeCells? In that case we need to make them generic.
> 
>>  - Configure DMA Master for src or dest.
> 
> Right now I have an algorithm that will (on the PL080, the PL081
> has only one master) try to select AHB1 for the memory and AHB2

PL080 have 2 Masters.

> for the device by checking if one address is fixed. If both or
> none addresses are fixed it will simply select AHB1 for source
> and AHB2 for destination.
> 
> Please elaborate on what algorithm you need for this!

In the same way, how other peripheral related data is passed to DMA driver,
(like request lines), we can also pass configuration and control information.
This will provide us with all features requested by me, as most of the
control will be from user only. In SPEAr6xx, Memory is accessible from Master1
only but in SPEAr3xx only from Master 2, similar is the pattern with few 
peripherals also and so i need control over DMA channel configuration.

>>  - Configure Flow controller of transfer.
> 
> Currently only done dynamically with DMA as the master for
> Mem2mem, mem2per and per2mem. Mastering from the peripherals
> is not supported. Do you have advanced features like that?

We have JPEG controller, which acts as a flow controller for JPEG to
mem transfer. (Synopsys JPEG Controller).

> 
> Anyway it can be passed in from platform data easily.
> 

But platform data will be passed one time only and we will not be able to
do it while transferring data at run time.
