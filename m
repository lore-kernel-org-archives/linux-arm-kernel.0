From: dcb314@hotmail.com (David Binderman)
Date: Mon, 4 Jan 2016 08:25:30 +0000
Subject: linux-4.4-rc8/arch/arm64/kernel/module.c:78: 32/64 bit problem ?
Message-ID: <DUB128-W158A3195DB26F149DD52E59CF20@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello there,

[linux-4.4-rc8/arch/arm64/kernel/module.c:78] -> [linux-4.4-rc8/arch/arm64/kernel/module.c:88]: (warning) Shifting 32-bit value by 64 bits is undefined behaviour. See condition at line 88.

Source code is

??? u64 imm_mask = (1 << len) - 1;
??? s64 sval = do_reloc(op, place, val);

??? switch (len) {
??? case 16:
??????? *(s16 *)place = sval;
??????? break;
??? case 32:
??????? *(s32 *)place = sval;
??????? break;
??? case 64:

So it seems that len can be 64. Suggest new code

??? u64 imm_mask = (1UL << len) - 1;
??? s64 sval = do_reloc(op, place, val);

??? switch (len) {
??? case 16:
??????? *(s16 *)place = sval;
??????? break;
??? case 32:
??????? *(s32 *)place = sval;
??????? break;
??? case 64:

Regards

David Binderman

 		 	   		  
