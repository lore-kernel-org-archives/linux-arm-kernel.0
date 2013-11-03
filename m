From: samuel.thibault@ens-lyon.org (Samuel Thibault)
Date: Sun, 3 Nov 2013 13:36:21 +0100
Subject: [next:master 23/358] undefined reference to `i2c_add_adapter'
In-Reply-To: <20131103120853.GA1731@localhost>
References: <5275bf42.KMmrPUiia86VoRbL%fengguang.wu@intel.com>
 <20131103120853.GA1731@localhost>
Message-ID: <20131103123621.GA9756@type.youpi.perso.aquilenet.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fengguang Wu, le Sun 03 Nov 2013 20:08:53 +0800, a ?crit :
> It's a bug fix that unveils the link errors.
> 
>    drivers/built-in.o: In function `__input_unregister_device':
>    input.c:(.text+0xf0e55): undefined reference to `input_led_disconnect'

Ok, so the "something like this" in the patch review was really not so
trivial :)

To summarize, input.c needs to call leds.c to register its LEDs,
and leds.c uses input.c functions, such as input_event. So in the
all-modules case we have a circular dependency, and when one is built-in
but not the other, we get an undefined reference.  In my original patch
input.c would not call leds.c when built as module, and then the module
wouldn't be useful any more.

So in the end it would probably be simpler to just stuff leds.c along
input.c in input.ko or built-in. CONFIG_INPUT_LEDS will thus become a
bool.  I'm working on that now.

Samuel
