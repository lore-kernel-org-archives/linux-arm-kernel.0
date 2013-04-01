From: collinsd@codeaurora.org (David Collins)
Date: Mon, 01 Apr 2013 14:08:48 -0700
Subject: How to represent negative values for device tree property
Message-ID: <5159F760.1080605@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am working on a thermal driver which needs to be able to read a
temperature threshold from a device tree property.  The hardware supports
thresholds in the range -204.8 to +204.7 C in 0.1 C steps.  I have found,
as I am sure others have as well, that dtc treats a '-' before an integer
in a dtsi file as a syntax error.  Therefore, I need some artificial way
to represent negative numbers in device tree.  Here are the possibilities
that I have thought of so far:

1. Use a second integer to specify the sign of the threshold:
     20000 mC --> <0 20000>
    -20000 mC --> <1 20000>
2. Use a string instead of an integer to specify the threshold and
   then convert it to an integer in the driver software:
     20000 mC --> "20000"
    -20000 mC --> "-20000"
3. Use units of millikelvin instead of millicelcius.  0 mC == 273150 mK
     20000 mC --> <293150>
    -20000 mC --> <253150>
4. Use an arbitrary offset e.g. 0 mC == 1000000
     20000 mC --> <1020000>
    -20000 mC --> <980000>
5. Use the unsigned 32-bit representation for 2?s-compliment
   signed 32-bit integer
     20000 mC --> <20000>
    -20000 mC --> <0xffffb1e0> or <4294947296>

Which of these options would you recommend using?  Is there any better way
to handle negative values that I haven?t listed?  What is the best general
case solution for specifying negative numbers in device tree?

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
