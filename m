From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 29 Jun 2012 14:57:18 +0200
Subject: [RFC PATCH 3/3] i2c: inititalise the actual transferred to zero
In-Reply-To: <20120629144002.3b4a31ee@endymion.delvare>
References: <1340967927-27354-1-git-send-email-shubhrajyoti@ti.com>
 <1340967927-27354-4-git-send-email-shubhrajyoti@ti.com>
 <20120629144002.3b4a31ee@endymion.delvare>
Message-ID: <20120629145718.697b6955@endymion.delvare>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 29 Jun 2012 14:40:02 +0200, Jean Delvare wrote:
> On Fri, 29 Jun 2012 16:35:27 +0530, Shubhrajyoti D wrote:
> > In i2c_smbus_xfer_emulated initialise the actual bytes
> > to zero.
> > 
> > Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> > ---
> >  drivers/i2c/i2c-core.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
> > index a6ad32b..fa7f799 100644
> > --- a/drivers/i2c/i2c-core.c
> > +++ b/drivers/i2c/i2c-core.c
> > @@ -1949,8 +1949,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
> >  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
> >  	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
> >  	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
> > -	struct i2c_msg msg[2] = { { addr, flags, 1, msgbuf0 },
> > -	                          { addr, flags | I2C_M_RD, 0, msgbuf1 }
> > +	struct i2c_msg msg[2] = { { addr, flags, 1, 0, msgbuf0 },
> > +				  { addr, flags | I2C_M_RD, 0, 0, msgbuf1 }
> >  	                        };
> >  	int i;
> >  	u8 partial_pec = 0;
> 
> Please convert to C99-style initialization while you're there. And this
> should be done first. Initializing i2c_msg.actual maybe rather belong
> to i2c_transfer though, so that all callers don't have to care.
> 
> Are you sure there are no other places that need the same fix in the
> kernel tree?

Actually I'm sure there are. At least:

drivers/video/matrox/matroxfb_maven.c: In function ?maven_get_reg?:
drivers/video/matrox/matroxfb_maven.c:140:9: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/video/matrox/matroxfb_maven.c:140:9: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/video/matrox/matroxfb_maven.c:141:6: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/video/matrox/matroxfb_maven.c:141:6: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/media/video/ks0127.c: In function ?ks0127_read?:
drivers/media/video/ks0127.c:322:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/ks0127.c:322:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/video/ks0127.c:323:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/ks0127.c:323:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/media/video/tvaudio.c: In function ?chip_read2?:
drivers/media/video/tvaudio.c:221:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/tvaudio.c:221:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/video/tvaudio.c:222:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/tvaudio.c:222:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/rtc/rtc-x1205.c: In function ?x1205_get_datetime?:
drivers/rtc/rtc-x1205.c:100:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:100:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:101:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:101:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c: In function ?x1205_get_status?:
drivers/rtc/rtc-x1205.c:145:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:145:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:146:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:146:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c: In function ?x1205_get_dtrim?:
drivers/rtc/rtc-x1205.c:282:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:282:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:283:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:283:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c: In function ?x1205_get_atrim?:
drivers/rtc/rtc-x1205.c:314:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:314:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:315:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:315:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c: In function ?x1205_validate_client?:
drivers/rtc/rtc-x1205.c:384:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:384:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:385:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:385:4: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:412:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:412:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:413:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:413:4: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c: In function ?x1205_rtc_read_alarm?:
drivers/rtc/rtc-x1205.c:447:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:447:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-x1205.c:448:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-x1205.c:448:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/rtc/rtc-s35390a.c: In function ?s35390a_set_reg?:
drivers/rtc/rtc-s35390a.c:53:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-s35390a.c:53:3: warning: (near initialization for ?msg[0].actual?) [enabled by default]
drivers/rtc/rtc-s35390a.c: In function ?s35390a_get_reg?:
drivers/rtc/rtc-s35390a.c:66:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-s35390a.c:66:3: warning: (near initialization for ?msg[0].actual?) [enabled by default]

  CC [M]  drivers/media/video/msp3400-kthreads.o
drivers/media/video/msp3400-driver.c: In function ?msp_reset?:
drivers/media/video/msp3400-driver.c:122:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:122:3: warning: (near initialization for ?reset[0].actual?) [enabled by default]
drivers/media/video/msp3400-driver.c:123:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:123:3: warning: (near initialization for ?reset[1].actual?) [enabled by default]
drivers/media/video/msp3400-driver.c:126:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:126:3: warning: (near initialization for ?test[0].actual?) [enabled by default]
drivers/media/video/msp3400-driver.c:127:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:127:3: warning: (near initialization for ?test[1].actual?) [enabled by default]
drivers/media/video/msp3400-driver.c: In function ?msp_read?:
drivers/media/video/msp3400-driver.c:146:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:146:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/video/msp3400-driver.c:147:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/video/msp3400-driver.c:147:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/rtc/rtc-rs5c372.c: In function ?rs5c_get_regs?:
drivers/rtc/rtc-rs5c372.c:107:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-rs5c372.c:107:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]

drivers/rtc/rtc-pcf8563.c: In function ?pcf8563_get_datetime?:
drivers/rtc/rtc-pcf8563.c:80:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-pcf8563.c:80:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-pcf8563.c:81:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-pcf8563.c:81:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/rtc/rtc-isl1208.c: In function ?isl1208_i2c_read_regs?:
drivers/rtc/rtc-isl1208.c:71:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:71:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-isl1208.c:73:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:73:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-isl1208.c: In function ?isl1208_i2c_set_regs?:
drivers/rtc/rtc-isl1208.c:93:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-isl1208.c:93:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]

drivers/rtc/rtc-em3027.c: In function ?em3027_get_time?:
drivers/rtc/rtc-em3027.c:52:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:52:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-em3027.c:53:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:53:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-em3027.c: In function ?em3027_set_time?:
drivers/rtc/rtc-em3027.c:79:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-em3027.c:79:3: warning: (near initialization for ?msg.actual?) [enabled by default]

drivers/rtc/rtc-ds1672.c: In function ?ds1672_get_datetime?:
drivers/rtc/rtc-ds1672.c:40:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:40:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-ds1672.c:41:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:41:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]
drivers/rtc/rtc-ds1672.c: In function ?ds1672_get_control?:
drivers/rtc/rtc-ds1672.c:102:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:102:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/rtc/rtc-ds1672.c:103:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/rtc/rtc-ds1672.c:103:3: warning: (near initialization for ?msgs[1].actual?) [enabled by default]

drivers/media/radio/saa7706h.c: In function ?saa7706h_get_reg16?:
drivers/media/radio/saa7706h.c:202:9: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/saa7706h.c:202:9: warning: (near initialization for ?msg[0].actual?) [enabled by default]
drivers/media/radio/saa7706h.c:203:5: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/saa7706h.c:203:5: warning: (near initialization for ?msg[1].actual?) [enabled by default]

drivers/media/radio/radio-tea5764.c: In function ?tea5764_i2c_read?:
drivers/media/radio/radio-tea5764.c:155:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/radio-tea5764.c:155:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/radio/radio-tea5764.c: In function ?tea5764_i2c_write?:
drivers/media/radio/radio-tea5764.c:170:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/radio-tea5764.c:170:3: warning: (near initialization for ?msgs[0].actual?) [enabled by default]

drivers/media/radio/si470x/radio-si470x-i2c.c: In function ?si470x_get_register?:
drivers/media/radio/si470x/radio-si470x-i2c.c:102:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:102:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c: In function ?si470x_set_register?:
drivers/media/radio/si470x/radio-si470x-i2c.c:123:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:123:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c: In function ?si470x_get_all_registers?:
drivers/media/radio/si470x/radio-si470x-i2c.c:150:4: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/media/radio/si470x/radio-si470x-i2c.c:150:4: warning: (near initialization for ?msgs[0].actual?) [enabled by default]

drivers/gpu/drm/nouveau/nouveau_bios.c: In function ?init_i2c_long_if?:
drivers/gpu/drm/nouveau/nouveau_bios.c:3534:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3534:3: warning: (near initialization for ?msg[0].actual?) [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: initialization makes integer from pointer without a cast [enabled by default]
drivers/gpu/drm/nouveau/nouveau_bios.c:3535:3: warning: (near initialization for ?msg[1].actual?) [enabled by default]

This needs to be all fixed (converted to C99-style struct
initialization) before your patch is considered for inclusion. And
there may be more that my config did not spot.

-- 
Jean Delvare
