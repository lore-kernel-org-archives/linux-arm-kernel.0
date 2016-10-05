From: sudeep.holla@arm.com (Sudeep Holla)
Date: Wed, 5 Oct 2016 11:42:36 +0100
Subject: Coresight ETF trace dump failed in Juno r1 with 4.8-rc8
In-Reply-To: <CAGhh56GeZkLT=sN4cEhUJMeuz+ZD6jMnU2sbb3yRVLESUcWrtg@mail.gmail.com>
References: <CAGhh56F-VWCCy82msQ8CimZ4a0a2h=tqR2qv1KcfeyuQXo=R1w@mail.gmail.com>
 <42c2ac9c-abdf-5341-01b5-3f342c5164b7@arm.com>
 <CAGhh56H7a9oEYxzEA4gGvBey=COMqwgisd4tzewU8DLGcGrsww@mail.gmail.com>
 <434a0256-de86-c1f0-0dc3-a38f55596e8e@arm.com>
 <CAGhh56GeZkLT=sN4cEhUJMeuz+ZD6jMnU2sbb3yRVLESUcWrtg@mail.gmail.com>
Message-ID: <7e1e514b-fc3b-ca96-4631-88d537019e08@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 05/10/16 06:27, Venkatesh Vivekanandan wrote:

[...]

>
> Hang is seen while trying to dump trace _after_ disabling the ETM
> source. Is it not supposed to work?.
> It works fine, when dumped before disabling ETM source. Please find
> the log below.
>
> linaro-test [rc=0]# echo 1 > 20010000.etf/enable_sink
> linaro-test [rc=0]# echo 1 > 22140000.etm/enable_source
> [   91.792145] coresight-tmc 20010000.etf: TMC-ETB/ETF enabled
> [   91.797719] coresight-funnel 20040000.main-funnel: FUNNEL inport 0 enabled
> [   91.804552] coresight-funnel 220c0000.cluster0-funnel: FUNNEL
> inport 1 enabled
> [   91.815990] coresight-etm4x 22140000.etm: ETM tracing enabled
> linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
> [  108.105492] coresight-tmc 20010000.etf: TMC read start
> [  108.404335] coresight-tmc 20010000.etf: TMC read end
> 65536+0 records in
> 65536+0 records out
> linaro-test [rc=0]# echo 0 > 20010000.etf/enable_sink
> linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
> [  125.069740] coresight-tmc 20010000.etf: TMC read start
> [  125.184370] coresight-tmc 20010000.etf: TMC read end
> 65536+0 records in
> 65536+0 records out
> linaro-test [rc=0]# echo 0 > 22140000.etm/enable_source
> [  140.271163] coresight-etm4x 22140000.etm: ETM tracing disabled
> [  140.276964] coresight-funnel 220c0000.cluster0-funnel: FUNNEL
> inport 1 disabled
> [  140.284211] coresight-funnel 20040000.main-funnel: FUNNEL inport 0 disabled
> [  140.291128] coresight-tmc 20010000.etf: TMC-ETB/ETF disabled
> linaro-test [rc=0]# dd if=/dev/20010000.etf of=/cstrace.bin bs=1
> <---- It hangs here...
>

I get dd: failed to open '/dev/20010000.etf': Invalid argument
once all the data is read.

> My firmware version,
>
> NOTICE:  Booting Trusted Firmware
> NOTICE:  BL1: v1.1(debug):4a1dcde
> NOTICE:  BL1: Built : 17:54:40, Nov 24 2015
> NOTICE:  BL1: Booting BL2
> NOTICE:  BL2: v1.1(debug):4a1dcde
> NOTICE:  BL2: Built : 17:54:40, Nov 24 2015
> NOTICE:  BL1: Booting BL3-1
> NOTICE:  BL3-1: v1.1(debug):4a1dcde
> NOTICE:  BL3-1: Built : 17:54:40, Nov 24 2015
> UEFI firmware (version 9ed6f7e built at 17:54:28 on Nov 24 2015)
>

OK, this looks as good as what Suzuki has, so should be fine.
But it doesn't list SCP version, can you see that from the Linux boot
logs ?(something like below)

"scpi_protocol scpi: SCP Protocol 1.2 Firmware 1.17.0 version"

-- 
Regards,
Sudeep
