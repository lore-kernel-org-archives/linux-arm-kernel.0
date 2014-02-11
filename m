From: Angus.Clark@st.com (Angus Clark)
Date: Tue, 11 Feb 2014 15:00:42 +0000
Subject: [PATCH RESEND v4 00/37] mtd: st_spi_fsm: Add new driver
In-Reply-To: <1390473085-24626-1-git-send-email-lee.jones@linaro.org>
References: <1390473085-24626-1-git-send-email-lee.jones@linaro.org>
Message-ID: <52FA3B1A.2070304@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

Sorry for the delay.  I have now had a quick look through the patches.  Just a
couple of points :-)

* stfsm_probe(): stfsm_fetch_platform_configs() needs to be called *before*
config() -- config() is based on platform capabilities.  Conceptually,
stfsm_fetch_platform_configs() should be called before stfsm_jedec_probe(), and
FLASH_FLAG_32BIT_ADDR should be moved out of stfsm_fetch_platform_configs(),
placed just after stfsm_jedec_probe() but before config().

* fsm_wait_busy(): logic not quite correct if we get a P_ERR or E_ERR error
after a timeout.  I am also not sure about returning (uint8_t)-EIO.  For what
its worth, this is what I did in response to Brian's comment about the race
condition:

static uint8_t fsm_wait_busy(struct stm_spi_fsm *fsm, unsigned int max_time_ms)
{
	struct fsm_seq *seq = &fsm_seq_read_status_fifo;
	unsigned long deadline;
	uint32_t status;
	int timeout = 0;

	/* Use RDRS1 */
	seq->seq_opc[0] = (SEQ_OPC_PADS_1 |
			   SEQ_OPC_CYCLES(8) |
			   SEQ_OPC_OPCODE(FLASH_CMD_RDSR));

	/* Load read_status sequence */
	fsm_load_seq(fsm, seq);

	/*
	 * Repeat until busy bit is deasserted, or timeout, or error (S25FLxxxS)
	 */
	deadline = jiffies + msecs_to_jiffies(max_time_ms);
	while (!timeout) {
		cond_resched();

		if (time_after_eq(jiffies, deadline))
			timeout = 1;

		fsm_wait_seq(fsm);

		fsm_read_fifo(fsm, &status, 4);

		if ((status & FLASH_STATUS_BUSY) == 0)
			return 0;

		if ((fsm->configuration & CFG_S25FL_CHECK_ERROR_FLAGS) &&
		    ((status & S25FL_STATUS_P_ERR) ||
		     (status & S25FL_STATUS_E_ERR)))
			return (uint8_t)(status & 0xff);

		if (!timeout)
			/* Restart */
			writel(seq->seq_cfg, fsm->base + SPI_FAST_SEQ_CFG);
	}

	dev_err(fsm->dev, "timeout on wait_busy\n");

	return FLASH_STATUS_TIMEOUT;
}

and:

static int fsm_wait_seq(struct stm_spi_fsm *fsm)
{
	unsigned long deadline = jiffies +
		msecs_to_jiffies(FSM_MAX_WAIT_SEQ_MS);
	int timeout = 0;

	while (!timeout) {
		if (time_after_eq(jiffies, deadline))
			timeout = 1;

		if (fsm_is_idle(fsm))
			return 0;

		cond_resched();
	}

	dev_err(fsm->dev, "timeout on sequence completion\n");

	return 1;
}


* "MFD" creeps into a few commit logs ;-)

Cheers,

Angus

On 01/23/2014 10:30 AM, Lee Jones wrote:
> Version 4:
>   Tended to Brian's review comments
>     - Checkpatch acceptance
>     - MODULE_DEVICE_TABLE() name slip correction
>     - Timeout issue(s) resolved
>     - Potential infinite loop mitigated
>     - Code clarity suggests heeded
>     - Duplication with MTD core code removed
>     - Upgraded to using ROUND_UP() helper
>     - Moved non-shared header code into main driver
>     - Relocated dynamic msg sequence stores into main struct
>     - Averted adaption of static (table) data
>     - Basic whitespace/spelling/data type/dev_err suggestions applied
>   
> Version 3:
>   Okay, this thing should be fully functional now. Identify a chip
>   based on it's JEDEC ID, Read, Write, Erase (all or by sector).
>   Support for various chip quirks added too.
> 
> Version 2:
>   The first bunch of these patches have been on the MLs before, but
>   didn't receive a great deal of attention for the most part. We are
>   a little more featureful this time however. We can now successfully
>   setup and configure the N25Q256. We still can't read/write/erase
>   it though. I'll start work on that next week and will provide it in
>   the next instalment.
> 
> Version 1:
>   First stab at getting this thing Mainlined. It doesn't do a great deal
>   yet, but we are able to initialise the device and dynamically set it up
>   correctly based on an extracted JEDEC ID.
> 
>  Documentation/devicetree/bindings/mtd/st-fsm.txt |   26 ++
>  arch/arm/boot/dts/stih416-b2105.dts              |   14 +
>  arch/arm/boot/dts/stih416-pinctrl.dtsi           |   12 +
>  drivers/mtd/devices/Kconfig                      |    8 +
>  drivers/mtd/devices/Makefile                     |    1 +
>  drivers/mtd/devices/serial_flash_cmds.h          |   81 ++++
>  drivers/mtd/devices/st_spi_fsm.c                 | 2124 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> 7 files changed, 2266 insertions(+)
> 
> 

-- 
-------------------------------------
Angus Clark
ST Microelectronics (R&D) Ltd.
1000 Aztec West, Bristol, BS32 4SQ
email: angus.clark at st.com
tel: +44 (0) 1454 462389
st-tina: 065 2389
-------------------------------------
