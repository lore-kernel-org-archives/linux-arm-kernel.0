From: jassisinghbrar@gmail.com (jassi brar)
Date: Fri, 4 Sep 2009 10:08:43 +0900
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090903151812.GE2954@sirena.org.uk>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902100500.GA4012@sirena.org.uk>
	<20090902121158.GU32606@prithivi.gnumonks.org>
	<1b68c6790909020644k757827f4kf590779f384ceccb@mail.gmail.com>
	<20090902144700.GD4012@sirena.org.uk>
	<1b68c6790909021738o3037c9dcve6699a7b272f6742@mail.gmail.com>
	<20090903121410.GC2954@sirena.org.uk>
	<1b68c6790909030639i55b7f18dy6c2961a2830e4862@mail.gmail.com>
	<20090903151812.GE2954@sirena.org.uk>
Message-ID: <1b68c6790909031808n5bb06987yfe06b3438b1d05b0@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brown<broonie@sirena.org.uk> wrote:
>
>> > The change you submitted would only be required if the PLLs are in use,
>> > and even then it only affects some PLL configurations.
>
>> So, on SMDK6410, I believe anyone who wants to run SoC-Slave mode will end up
>> making use of the WM8580 PLLs.
>
> Historically the SMDK drivers in the BSPs have always run the CODEC as
> slave; I've never been sure why. ?I believe most of the other users are
> using a crystal that directly generates the rates they need.
Yes, samsung BSPs have always implemented SoC-Master by dafault
perhaps because most I2S Codec Chips run as Slaves by default.
Now, we want to support as many configurations as there are.

>> I hope we agree the SoC-Master/Slave option should be selected in make
>> menuconfig.
>> Direction of LRCLK, BCLK thus gets decided there.
>
> The machine driver should just pick a suitable configuration and go with
> it. ?This isn't something which users should need to be concerned about
> having to configure - it's way more detail than they need to know to get
> audio working, it just makes support harder. ?If someone is interested
> in playing about with these options they can always go and edit the
> source code but it's a very niche use case.
I think the 'suitable' configuration is the one that the user(device
maker) wants.
Because i think platform designers already are pretty sure of what
mode they wanna run the SoC-I2S in - they won't run SoC in MASTER mode
if they have attached a good OSC to the CODEC.

Btw, what cud be the criteria of switch from SoC Master to SoC Slave
during runtime?
Or perhaps we are simply putting the same thing differently.

>> IMHO, source of MCLK - I2SCDCLK, PCLK, SCLK_Audio(with further
>> options) - is better
>> decided during compile-time too. Otherwise, put-get-put-setrate-'ing
>> different clocks, according
>> to the LRCLK needed, in runtime will add more complexity than
>> flexibility to the driver. Or so do i think.
>
> If you're talking about the CPU DAI then all this stuff needs to be
> decided at runtime - compile time selection causes lots of problems. ?It
> means that it's not possible to build kernels which will run on boards
> with different configurations, nor is it possible to have a single
> machine using multiple I2S ports with different configurations.
>
> If you're talking about the machine driver then yes, this should just be
> fixed in the source code as discussed above.
Yes, i am talking about machine driver.
Cpu-Dai driver shud be as generic and implement as many SoC features
as possible.
Machine driver should runtime configure Cpu_Dai and Codec_Dai as per
the Master/Slave and Clock sourcing options it "got from make
menuconfig".

>Like I say, it's a bit hard to comment in detail about the v5 block without seeing
> any information about it.
well.....i can only acknowledge your point :)

>> I meant we can atleast make names of functions and datastructures 2410 neutral,
>> like changing from s3c24xx_i2s to samsung_i2s_v2 or somthing like that.
>> i.e, designing around IPs rather than SoCs.
>
> I don't have any massive problem with doing this but if you wish to do
> this be sure to ensure that big reformatting changes such as this are
> isolated from all other changes. ?Part of the reason nothing's ever been
> changed is that changes like this are very disruptive relative to their
> benefits.
I think it's not a good enough reason that we don't see any problem.
The restructuring shud, and wud, only be started if people(esp Ben)
find it a better way.
I, for one, strongly believe that.
Ofcourse, it won't be a one-shot change but slowly we can submit
patches and design changes towards achieving that.
