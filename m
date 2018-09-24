From: aford173@gmail.com (Adam Ford)
Date: Mon, 24 Sep 2018 14:21:09 -0500
Subject: [PATCH] regulator: pfuze100-regulator: add coin support
In-Reply-To: <20170309141443.20564-1-george.mccollister@gmail.com>
References: <20170309141443.20564-1-george.mccollister@gmail.com>
Message-ID: <CAHCN7xLEHw4vN8gud+vPkVBX3tSsBM1HTnRCi6fF3VxYiQYfmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 9, 2017 at 8:17 AM George McCollister
<george.mccollister@gmail.com> wrote:
>
> Add support for PF0200 coin cell/super capacitor charger which works as
> a current limited voltage source via the LICELL pin. When VIN goes below
> a certain threshold LICELL is used to provide power for VSNVS which is
> usually used to hold up secure non-volatile storage and the real-time
> clock on the SoC.
>

I know this is patch is an old thread by now, but is there something
precluding this from being added the pfuze100 as well?

[snip]

I am trying to add:

@@ -324,6 +324,7 @@ static struct pfuze_regulator pfuze100_regulators[] = {
        PFUZE100_VGEN_REG(PFUZE100, VGEN4, PFUZE100_VGEN4VOL, 1800000,
3300000, 100000),
        PFUZE100_VGEN_REG(PFUZE100, VGEN5, PFUZE100_VGEN5VOL, 1800000,
3300000, 100000),
        PFUZE100_VGEN_REG(PFUZE100, VGEN6, PFUZE100_VGEN6VOL, 1800000,
3300000, 100000),
+       PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
 };

 static struct pfuze_regulator pfuze200_regulators[] = {
@@ -377,6 +378,7 @@ static struct of_regulator_match pfuze100_matches[] = {
        { .name = "vgen4",      },
        { .name = "vgen5",      },
        { .name = "vgen6",      },
+       { .name = "coin",       },
 };

but I am getting bulid errors:

drivers/regulator/pfuze100-regulator.c:327:20: error: ?PFUZE100_COIN?
undeclared here (not in a function); did you mean ?PFUZE200_COIN??
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro ?PFUZE100_COIN_REG?
  [_chip ## _ ##  _name] = { \
   ^~~~~
drivers/regulator/pfuze100-regulator.c:327:20: error: array index in
initializer not of integer type
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro ?PFUZE100_COIN_REG?
  [_chip ## _ ##  _name] = { \
   ^~~~~
drivers/regulator/pfuze100-regulator.c:327:20: note: (near
initialization for ?pfuze100_regulators?)
  PFUZE100_COIN_REG(PFUZE100, COIN, PFUZE100_COINVOL, 0x7, pfuze100_coin),
                    ^~~~~~~~
drivers/regulator/pfuze100-regulator.c:240:3: note: in definition of
macro ?PFUZE100_COIN_REG?
  [_chip ## _ ##  _name] = { \
   ^~~~~

I am not entirely understanding how the macro is supposed to work.
Any suggestions?

thanks,

adam


> --
> 2.11.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
