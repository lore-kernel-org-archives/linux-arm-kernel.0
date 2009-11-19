From: dsilvers@simtec.co.uk (Daniel Silverstone)
Date: Thu, 19 Nov 2009 13:52:36 +0000
Subject: [patch 1/1] TOUCHSCREEN: S3C24XX touchscreen driver from
	Arnaud  Patard.
In-Reply-To: <4B052D50.2070002@simtec.co.uk>
References: <20091118232939.201290297@fluff.org.uk>
	<20091118232948.063635416@fluff.org.uk>
	<20091119025930.GA20172@core.coreip.homeip.net>
	<4B052D50.2070002@simtec.co.uk>
Message-ID: <20091119135236.GB5535@digital-scurf.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 11:34:40AM +0000, Ben Dooks wrote:
>>> +		input_report_key(ts.input, BTN_TOUCH, 1);
>>> +		input_report_abs(ts.input, ABS_PRESSURE, 1);
>> No fake pressure events please, BTN_TOUCH should be enough.
> I'd have to check, IIRC tslib needs these to function properly.

Indeed it does -- otherwise it won't work.  Yes you could try going around and
patching TSLIB but so many people use it that it is principle-of-least-surprise
to produce pressure events.

>>> +	ts.input->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);
>>> +	input_set_abs_params(ts.input, ABS_X, 0, 0x3FF, 0, 0);
>>> +	input_set_abs_params(ts.input, ABS_Y, 0, 0x3FF, 0, 0);
>>> +	input_set_abs_params(ts.input, ABS_PRESSURE, 0, 1, 0, 0);
>> Drop ABS_PRESSURE.
> ok, see above.

The same applies here -- claim ABS_PRESSURE or tslib won't operate with the
touchscreen.

While it is tempting to be 100% exactly correct to what the hardware reports
(which is only TOUCH not PRESSURE) it is preferable to work with the software
which the majority of people use -- namely tslib.

I would strongly argue against removing the ABS_PRESSURE stuff personally,
despite it being essentially a lie.

Regards,

Daniel.

-- 
Daniel Silverstone                              http://www.simtec.co.uk/
