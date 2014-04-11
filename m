From: mark.roszko@gmail.com (Mark Roszko)
Date: Fri, 11 Apr 2014 13:53:00 -0400
Subject: [PATCH] pinctrl/at91: Fix pin_to_mask
In-Reply-To: <21196207.LSji5uQPhJ@kongar>
References: <1397230537-8727-1-git-send-email-alexanders83@web.de>
 <075734B2-F667-47DE-A813-8371456A31B9@jcrosoft.com>
 <21196207.LSji5uQPhJ@kongar>
Message-ID: <CAJjB1qLC6HBwz=bBef-EGH8wrfpqE3DdTGcfGrwb_r1qCdRPRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The member struct pin inside the at91_pmx_pin structs is already the
bank pin number, it was documented at the top of the driver.

/**
   * struct at91_pmx_pin - describes an At91 pin mux
   * @bank: the bank of the pin
   * @pin: the pin number in the @bank
   * @mux: the mux mode : gpio or periph_x of the pin i.e. alternate function.
   * @conf: the configuration of the pin: PULL_UP, MULTIDRIVE etc...
   */

if the pmx_pin->pin member wasn't already a bank number, then other
logic would break such as if (pin->pin >= MAX_NB_GPIO_PER_BANK) in
pin_check_config. In fact pmx_enable calls pin_check_config and should
catch an error.
