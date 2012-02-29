From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 29 Feb 2012 23:35:40 +0100
Subject: Linux 3.3-rc5 and pxa-gpio possible regression
Message-ID: <87wr75tghv.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi all,

I've tried the 3.3-rc5 kernel and my boot hangs (PXA270 platform).

After some investigation, I get a NULL pointer exception in the first
gpio_set_value(). After some digging, I know that :
 - in drivers/gpio/gpiolib.c, gpio_desc[] is filled with zeroes
 - this is because in drivers/gpio/pxa-gpio.c, the probe function exits with an
 error
 - this leads to line 496 of pxa-gpio.c:
	clk = clk_get(&pdev->dev, NULL);
         \--------> here clk is 0xfffffffe
	if (IS_ERR(clk)) {
		dev_err(&pdev->dev, "Error %ld to get gpio clock\n",
			PTR_ERR(clk));
		iounmap(gpio_reg_base);
		return PTR_ERR(clk);
	}
   Therefore, gpios are not initialized.

As a bonus, I have the content of platform device if anyone is interested in
[1]. I think the clock API been modified somewhere, and the regression sneaked
in, but I have not investigated much further.

Would anyone with clock API knowledge shed some light why I have this error, and
why nobody sees it excepting me ? I'm wondering if my config has something
wrong, or if other PXA based platforms are affected.

Cheers.

-- 
Robert

[1] Platform device
(gdb) p *pdev
$12 = {name = 0xc038f118 "pxa-gpio", id = -1, dev = {parent = 0xc0406020, p = 0xc383f8a0, kobj = {name = 0xc3842820 "pxa-gpio", entry = {next = 0xc03fae6c, prev = 0xc383844c}, 
      parent = 0xc0406028, kset = 0xc381dd20, ktype = 0xc0405ed0, sd = 0xc38419f0, kref = {refcount = {counter = 3}}, state_initialized = 1, state_in_sysfs = 1, state_add_uevent_sent = 1, 
      state_remove_uevent_sent = 0, uevent_suppress = 0}, init_name = 0x0, type = 0x0, mutex = {count = {counter = 0}, wait_lock = {{rlock = {raw_lock = {<No data fields>}}}}, wait_list = {
        next = 0xc03fa028, prev = 0xc03fa028}}, bus = 0xc0405fe0, driver = 0xc040211c, platform_data = 0x0, power = {power_state = {event = 0}, can_wakeup = 0, async_suspend = 0, 
      is_prepared = false, is_suspended = false, ignore_children = false, lock = {{rlock = {raw_lock = {<No data fields>}}}}, entry = {next = 0xc03faeb4, prev = 0xc3838494}, completion = {
        done = 2147483647, wait = {lock = {{rlock = {raw_lock = {<No data fields>}}}}, task_list = {next = 0xc03fa050, prev = 0xc03fa050}}}, wakeup = 0x0, wakeup_path = false, 
      subsys_data = 0x0, constraints = 0x0}, pm_domain = 0x0, dma_mask = 0x0, coherent_dma_mask = 0, dma_parms = 0x0, dma_pools = {next = 0xc03fa07c, prev = 0xc03fa07c}, dma_mem = 0x0, 
    archdata = {<No data fields>}, of_node = 0x0, devt = 0, id = 0, devres_lock = {{rlock = {raw_lock = {<No data fields>}}}}, devres_head = {next = 0xc03fa094, prev = 0xc03fa094}, 
    knode_class = {n_klist = 0x0, n_node = {next = 0x0, prev = 0x0}, n_ref = {refcount = {counter = 0}}}, class = 0x0, groups = 0x0, release = 0}, num_resources = 4, resource = 0xc03fa0c8, 
  id_entry = 0x0, mfd_cell = 0x0, archdata = {<No data fields>}}
