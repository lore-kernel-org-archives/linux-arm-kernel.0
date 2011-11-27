From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Sun, 27 Nov 2011 11:26:06 +0000
Subject: [PATCH] mx28: added LRADC and touchscreen support
In-Reply-To: <201111251602.35227.arnd@arndb.de>
References: <1322135394-4097-1-git-send-email-rusko.peter@prolan.hu>
 <201111251602.35227.arnd@arndb.de>
Message-ID: <4ED21E4E.5090004@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

...
>> diff --git a/arch/arm/mach-mxs/include/mach/lradc.h b/arch/arm/mach-mxs/include/mach/lradc.h
>> new file mode 100644
>> index 0000000..c2c0a7d
> 
>> +
>> +int hw_lradc_use_channel(int);
>> +int hw_lradc_unuse_channel(int);
>> +extern u32 hw_lradc_vddio(void);
>> +void hw_lradc_set_delay_trigger_kick(int trigger, int value);
>> +void hw_lradc_configure_channel(int channel, int enable_div2,
>> +		int enable_acc, int samples);
>> +int hw_lradc_present(int channel);
>> +int hw_lradc_init_ladder(int channel, int trigger, unsigned sampling);
>> +int hw_lradc_stop_ladder(int channel, int trigger);
>> +void hw_lradc_set_delay_trigger(int trigger, u32 trigger_lradc,
>> +		u32 delay_triggers, u32 loops, u32 delays);
>> +void hw_lradc_clear_delay_trigger(int trigger, u32 trigger_lradc,
>> +		u32 delay_triggers);
> 
> As indicated by Shawn, adding a new driver specific kernel-level ADC
> interface is not a good idea. IIRC, the result of the last discussion
> was that all ADC drivers should be part of IIO and you should use
> the IIO in-kernel interfaces. Not sure what the state of that code
> is, but if it's not in mainline yet, you should work with Jonathan
> to make sure it gets there. Having more users for that code can
> only speed up the process, and I'm going to refuse another ADC driver
> in drivers/misc or arch/arm/mach-*/.

Quick summary of IIO status.  Nothing is in mainline yet.  Intent is to
get the first set of core code (including in kernel pull interfaces)
into linux-next fairly shortly (these have had enough postive feedback
now I think).  Doing push interfaces (as I think we would need here) is
possible with existing patches on top of the stuff in the iio staging
tree but there are some 'interesting' cases where both push and pull
interfaces exist that still need addressing.

Also, note the push interface stuff (e.g. interrupt driven) requires a
lot more of the IIO infrastructure to be in place (buffered support and
the demux unit) so may still be some time.  Personally my time is
currently very restricted so all the help anyone can offer is most welcome!

Jonathan
