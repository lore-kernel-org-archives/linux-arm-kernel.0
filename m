From: mturquette@linaro.org (Mike Turquette)
Date: Mon,  3 Jun 2013 10:53:07 -0700
Subject: [PATCH RFC 0/3] clk: dt: bindings for mux & divider clocks
Message-ID: <1370281990-15090-1-git-send-email-mturquette@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces binding definitions for common register-mapped
clock multiplexor and divider IP blocks, and the corresponding setup
functions once they are matched.  The bindings are close the struct
definitions but please don't hold that against the binding: the struct
definitions closely model the hardware.

The only missing basic clock type is the gate clock.  A binding for that
was posted some time back and is similar in spirit to these[1].  I guess
we'll need to decide whether register-level programming details belong
in DT.  I believe they do since those details describe the hardware.

Note that there is still no generic clock driver that matches these
basic types, but it would be trivial to write one.  Thoughts on that?
Is it better for each of the basic clock types to be a driver that
matches, or should there be one drivers/clk/clk-basic.c which matches
all of the basic clock building blocks?  I like the latter for aesthetic
purposes.

I am using this code while converting the OMAP4 clock data over to DT
and some common boilerplate code can be factored out of several clock
drivers if this is merged.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137878.html

Mike Turquette (3):
  clk: of: helper for determining number of parent clocks
  clk: dt: binding for basic multiplexor clock
  clk: dt: binding for basic divider clock

 .../devicetree/bindings/clock/divider-clock.txt    | 80 ++++++++++++++++++++
 .../devicetree/bindings/clock/mux-clock.txt        | 75 ++++++++++++++++++
 drivers/clk/clk-divider.c                          | 88 +++++++++++++++++++++-
 drivers/clk/clk-mux.c                              | 65 +++++++++++++++-
 drivers/clk/clk.c                                  |  6 ++
 include/linux/clk-provider.h                       |  8 +-
 6 files changed, 319 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/divider-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/mux-clock.txt

-- 
1.8.1.2
