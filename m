From: danindrey@mail.ru (Andrey Danin)
Date: Tue, 8 Sep 2015 15:31:39 +0300
Subject: [PATCH v3 1/4] i2c: tegra: implement slave mode
In-Reply-To: <20150908114621.GB15793@katana>
References: <1437424546-30405-1-git-send-email-danindrey@mail.ru>
 <1437424546-30405-2-git-send-email-danindrey@mail.ru>
 <20150724092720.GA1597@katana> <55B210F4.6030700@mail.ru>
 <20150724105251.GA22787@katana> <55D5C4AA.2000307@mail.ru>
 <20150908114621.GB15793@katana>
Message-ID: <55EED52B.8080701@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram, thanks!

On 08.09.2015 14:46, Wolfram Sang wrote:
>
>> Sorry for the long delay. I tried to analyze the issue. Attached patch works
>> on AC100 (Misha Komarovsky helped me with testing).
>>
>> Wolfram could you please try the patch with your environment?
>
> No change, sadly. I don't get slave interrupts.

Slave ISR is called only if slave device is registered on a bus. Do you 
get master interrupts ?

>> Init function is called multuple times. If I2C controller works
>> in slave mode, then driver must keep slave registers otherwise
>> slave configuration will be reseted.
>
> This patch does not tackle the main issue, though. There should not be a
> "slave mode" for the controller.

Looks like my commit message is not clear enough :(
 >> If I2C controller works in slave mode, then ...
I mean something like this:
"If slave functionality is enabled, then ..."

> It can be a master and slave
> simultaneously and should do the right thing depending on what's
> happening on the bus. The Tegra2 manual I have says "The Master can
> address the internal slave (for basic testing) or an external 7-bit or
> 10-bit addressed Slave device." So even a loopback should be possible
> (if we trust the manual ;)).

Slave logic is not enabled by default (we don't set up proper 
configuration and slave address). We can enable it by default but it is 
useless without driver that will handle requests.

We used i2cdetect on the I2C bus where master NVEC controller is 
connected. i2cdetect found devices on the bus. Also keyboard and mouse 
was running fine after that (slave logic was not disabled).
