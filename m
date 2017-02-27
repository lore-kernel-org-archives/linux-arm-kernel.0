From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 27 Feb 2017 05:04:11 +0100
Subject: [RFC] ADS7846 touchscreen questions
Message-ID: <2ffa89be-e875-4b47-9598-87ccb670da3f@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I'm trying to add ADS7846 touchscreen support for arch/arm/mach-pxa/magician machine, but I have some questions about functionality of the driver and/or possible enhancements.

There seems to be an unnecessary computation of a pressure in ads7846_report_state(). The test for ignoring the measured data should be done before the computation. I would transfer it inside ads7846_irq() before the actual ads7846_report_state() call. Or at least before the pressure computation.

	if (!ts->stopped && !packet->tc.ignore) {
		ads7846_report_state(ts);
	}

If a 7845 model uses penirq_recheck_delay_usecs pdata, then get_pendown_state(ts) test for discarding the data is called twice.

Anyway the last measurement will be almost always interrupted by pen up event. IMO it should be tested every time, preferably before ads7846_report_state() call. I would transfer it along with penirq_recheck_delay_usecs delay.

With those changes the debug printks for different models could be merged along with some pressure computations.

The arch/arm/mach-pxa/lubbock.c machine returns a constant 0 for get_pendown_state test. Does the touchscreen driver work at all? It seems it cannot call ads7846_report_state() at all (as a condition of while() will fail).

Are there directions how to define x_plate_ohms constant? It seems to me that in extreme situations where z2 and x values will be near a maximum (4095) the unsigned int Rt will overflow when the constant x_plate_ohms is over 256. My machine has 317 ohms for x and 500 ohms for y.

Thanks,
Petr
