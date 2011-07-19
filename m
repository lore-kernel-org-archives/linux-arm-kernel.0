From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 19 Jul 2011 16:30:48 +0200
Subject: AT91 SDIO WiFi no working
In-Reply-To: <4E1DE39F.3030104@nlink.com.br>
References: <4E1DE39F.3030104@nlink.com.br>
Message-ID: <4E259518.3020902@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all.

On 7/13/2011 8:27 PM, Paulo Fragoso wrote:
> Hi,
>
> We are trying to run SDIO WiFI with a board based on AT91sam9 and our 
> configuration and firmware files are apparently ok but now we have got 
> this erro:
>
> root at buildroot:~# modprobe libertas
> root at buildroot:~# modprobe libertas_sdio.ko 
> helper_name=/lib/firmware/sd8686_v8_
> helper.bin fw_name=/lib/firmware/sd8686_v8.bin
> libertas_sdio: Libertas SDIO driver
> libertas_sdio: Copyright Pierre Ossman
> libertas: can't load helper firmware
> libertas: failed to load helper firmware
> libertas_sdio: probe of mmc0:0001:1 failed with error -2
>
> udev is running too, what might be happening?
>
> Thanks,
> Paulo.
>
I am also facing some problems using the libertas driver. I am not sure 
that it's the same problem as Paulo because I don't know which kernel 
version he is using. It's probably not the best place to talk about this 
because I don't think the problem is coming from at91 mmc driver, that's 
why I also send this message  to libertas-dev.

I have made my tests with 3.0-rc7 version this what I have (I have added 
some traces) :

    root at at91sam9g20ek:~# insmod libertas.ko libertas_debug=0x5063a7
    [   52.220000] libertas enter: lbs_init_module()
    [   52.220000] libertas leave: lbs_init_module()
    root at at91sam9g20ek:~#
    root at at91sam9g20ek:~#
    root at at91sam9g20ek:~#
    root at at91sam9g20ek:~# insmod libertas_sdio.ko
    helper_name="helper_sd.bin" fw_nam
    e="sd8686.bin"
    [   55.450000] libertas enter: if_sdio_init_module()
    [   55.450000] libertas_sdio: Libertas SDIO driver
    [   55.460000] libertas_sdio: Copyright Pierre Ossman
    [   55.460000] libertas leave: if_sdio_init_module(), ret 0
    root at at91sam9g20ek:~# [   58.020000] mmc1: new SDIO card at address 0001
    [   58.030000] libertas enter: if_sdio_probe()
    [   58.030000] libertas sdio: class = 0x7, vendor = 0x2DF, device =
    0x9103, model = 0xB, ioport = 0x10000
    [   58.040000] libertas enter: if_sdio_prog_firmware()
    [   58.060000] libertas sdio: firmware status = 0x0
    [   58.060000] libertas sdio: scratch ret = 0
    [   58.060000] libertas_sdio mmc1:0001:1: load user helper firmware:
    helper_sd.bin
    [   58.110000] libertas_sdio mmc1:0001:1: helperfw size: 2516
    [   58.120000] libertas_sdio mmc1:0001:1: load user main firmware:
    sd8686.bin
    [   58.170000] libertas_sdio mmc1:0001:1: mainfw size: 2516
    [   58.170000] libertas enter: if_sdio_prog_helper()
    [   58.380000] libertas sdio: waiting for helper to boot...
    [   58.380000] libertas leave: if_sdio_prog_helper(), ret 0
    [   58.390000] libertas sdio: Helper firmware loaded
    [   58.390000] libertas enter: if_sdio_prog_real()
    [   58.400000] libertas sdio: firmware size: 2516
    [   58.400000] libertas sdio: firmware wants 16 bytes
    [   58.410000] libertas sdio: sending 16 bytes (32 bytes) chunk
    [   58.420000] libertas sdio: firmware wants 17 bytes
    [   58.420000] libertas sdio: firmware helper signalled error
    [   58.430000] libertas_sdio: failed to load firmware
    [   58.430000] libertas leave: if_sdio_prog_real(), ret -5
    [   58.440000] libertas leave: if_sdio_prog_firmware(), ret -5
    [   58.450000] libertas leave: if_sdio_probe(), ret -5
    [   58.450000] libertas_sdio: probe of mmc1:0001:1 failed with error -5


The first problem is the main firmware size which is the size of the 
helper firmware.

Now the second problem:

    [1140] msg_queue_insert: seq 540 queued, 'add' 'firmware'
    [1170] run_program: 'firmware.sh'
    [1140] udev_event_run: seq 540 forked, pid [1170], 'add' 'firmware',
    0 seconds old
    [1170] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    helper_sd.bin'
    [1170] run_program: '/lib/udev/firmware.sh' returned with status 0
    [1170] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1170] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1170] run_program: '/lib/udev/firmware.sh'
    [1170] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    helper_sd.bin'
    [1170] run_program: '/lib/udev/firmware.sh' returned with status 0
    [1170] udev_event_run: seq 540 finished with 0
    [1140] msg_queue_insert: seq 541 queued, 'remove' 'firmware'
    [1175] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1175] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1175] udev_event_run: seq 541 finished with 0
    [1140] udev_event_run: seq 541 forked, pid [1175], 'remove'
    'firmware', 0 seconds old
    [1140] msg_queue_insert: seq 542 queued, 'add' 'firmware'
    [1140] udev_event_run: seq 542 forked, pid [1176], 'add' 'firmware',
    0 seconds old
    [1176] run_program: 'firmware.sh'
    [1176] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    sd8686.bin'
    [1176] run_program: '/lib/udev/firmware.sh' (stderr) 'udev firmware
    loader misses sysfs directory'
    [1176] run_program: '/lib/udev/firmware.sh' returned with status 1
    [1176] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1176] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1176] run_program: '/lib/udev/firmware.sh'
    [1176] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    sd8686.bin'
    [1176] run_program: '/lib/udev/firmware.sh' (stderr) 'udev firmware
    loader misses sysfs directory'
    [1176] run_program: '/lib/udev/firmware.sh' returned with status 1
    [1176] udev_event_run: seq 542 finished with -1


I don't understand why I have two to firmware.sh for helper_sd.bin and 
also for sd8686.bin. The second part I don't understand is why the sysfs 
entries for the firmware have been removed between the two uevent.


The function dealing with firmwares is lbs_get_firmware where we have 
two successive request_firmware calls. I am confused about the behavior 
but I had the feeling that the two successive request_firmware calls was 
the problem because the main firmware size is those of the helper 
firmware. That's why I did this:

    commit 53ad5481c1d659da920e950f47ae25cbfc288239
    Author: Ludovic Desroches <ludovic.desroches@atmel.com>
    Date:   Tue Jul 19 15:52:26 2011 +0200

         libertas: separate helper and main firmware request

         Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

    diff --git a/drivers/net/wireless/libertas/if_sdio.c
    b/drivers/net/wireless/libertas/if_sdio.c
    index 224e985..01e530c 100644
    --- a/drivers/net/wireless/libertas/if_sdio.c
    +++ b/drivers/net/wireless/libertas/if_sdio.c
    @@ -723,7 +723,7 @@ static int if_sdio_prog_firmware(struct
    if_sdio_card *card)
          }

          ret = lbs_get_firmware(&card->func->dev, lbs_helper_name,
    lbs_fw_name,
    -                card->model, &fw_table[0], &helper, &mainfw);
    +                card->model, &fw_table[0], &helper, NULL);
          if (ret) {
              pr_err("failed to find firmware (%d)\n", ret);
              goto out;
    @@ -735,6 +735,10 @@ static int if_sdio_prog_firmware(struct
    if_sdio_card *card)

          lbs_deb_sdio("Helper firmware loaded\n");

    +    ret = lbs_get_firmware(&card->func->dev, lbs_helper_name,
    lbs_fw_name,
    +                card->model, &fw_table[0], NULL, &mainfw);
    +
    +
          ret = if_sdio_prog_real(card, mainfw);
          if (ret)
              goto out;
    diff --git a/drivers/net/wireless/libertas/main.c
    b/drivers/net/wireless/libertas/main.c
    index 8c40949..b35ca07 100644
    --- a/drivers/net/wireless/libertas/main.c
    +++ b/drivers/net/wireless/libertas/main.c
    @@ -1075,11 +1075,9 @@ int lbs_get_firmware(struct device *dev,
    const char *user_helper,
          const struct lbs_fw_table *iter;
          int ret;

    -    BUG_ON(helper == NULL);
    -    BUG_ON(mainfw == NULL);
    -
          /* Try user-specified firmware first */
    -    if (user_helper) {
    +    if (user_helper && helper) {
    +        dev_info(dev, "load user helper firmware: %s\n", user_helper);
              ret = request_firmware(helper, user_helper, dev);
              if (ret) {
                  dev_err(dev, "couldn't find helper firmware %s\n",
    @@ -1087,7 +1085,8 @@ int lbs_get_firmware(struct device *dev, const
    char *user_helper,
                  goto fail;
              }
          }
    -    if (user_mainfw) {
    +    if (user_mainfw && mainfw) {
    +        dev_info(dev, "load user main firmware: %s\n", user_mainfw);
              ret = request_firmware(mainfw, user_mainfw, dev);
              if (ret) {
                  dev_err(dev, "couldn't find main firmware %s\n",
    @@ -1096,8 +1095,7 @@ int lbs_get_firmware(struct device *dev, const
    char *user_helper,
              }
          }

    -    if (*helper && *mainfw)
    -        return 0;
    +    return 0;

          /* Otherwise search for firmware to use.  If neither the helper or
           * the main firmware were specified by the user, then we need to



Everything is ok with my patch but I would like to understand what 
happens, why I need this patch and if it is correct or just a lucky 
horrible hack ! Here the udev logs seems more logical even if I still 
have two requests for each firmware. The first call is ok but the second 
fails because of missing sysfs entries.

    [1113] msg_queue_insert: seq 524 queued, 'add' 'firmware'
    [1113] udev_event_run: seq 524 forked, pid [1125], 'add' 'firmware',
    0 seconds old
    [1125] run_program: 'firmware.sh'
    [1125] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    helper_sd.bin'
    [1125] run_program: '/lib/udev/firmware.sh' returned with status 0
    [1125] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1125] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1125] run_program: '/lib/udev/firmware.sh'
    [1125] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    helper_sd.bin'
    [1125] run_program: '/lib/udev/firmware.sh' (stderr) 'udev firmware
    loader misses sysfs directory'
    [1125] run_program: '/lib/udev/firmware.sh' returned with status 1
    [1125] udev_event_run: seq 524 finished with -1
    [1113] msg_queue_insert: seq 525 queued, 'remove' 'firmware'
    [1113] udev_event_run: seq 525 forked, pid [1130], 'remove'
    'firmware', 0 seconds old
    [1130] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1130] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1130] udev_event_run: seq 525 finished with 0
    [   95.140000] libertas_sdio mmc1:0001:1: load user main firmware:
    sd8686.bin
    [1113] msg_queue_insert: seq 526 queued, 'add' 'firmware'
    [1113] udev_event_run: seq 526 forked, pid [1131], 'add' 'firmware',
    0 seconds old
    [1131] run_program: 'firmware.sh'
    [1131] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    sd8686.bin'
    [1131] run_program: '/lib/udev/firmware.sh' returned with status 0
    [1131] pass_env_to_socket: passed -1 bytes to socket
    '@/org/kernel/udev/monitor',
    [1131] pass_env_to_socket: passed -1 bytes to socket
    '/org/kernel/udev/monitor',
    [1131] run_program: '/lib/udev/firmware.sh'
    [1131] run_program: '/lib/udev/firmware.sh' (stdout) 'firmware:
    sd8686.bin'
    [1131] run_program: '/lib/udev/firmware.sh' (stderr) 'udev firmware
    loader misses sysfs directory'
    [1131] run_program: '/lib/udev/firmware.sh' returned with status 1
    [1131] udev_event_run: seq 526 finished with -1


Thanks for you help.

Regards,

Ludovic
