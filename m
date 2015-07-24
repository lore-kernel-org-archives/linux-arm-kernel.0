From: suzuki.poulose@arm.com (Suzuki K. Poulose)
Date: Fri, 24 Jul 2015 10:43:57 +0100
Subject: sample: arm64 cpu feature: Test program
In-Reply-To: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1437731037-25795-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

Attached is a sample program that fetches all the emulated
cpu feature registers and traps on accessing an invalid
id register.


---

/*
 * show_sysregs_all: Sample program to retrieve the
 * CPU feature registers.
 *
 * Author: Suzuki K. Poulose <suzuki.poulose@arm.com>
 *
 * Copyright (C) 2015 ARM Ltd.
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */



#include <stdio.h>

///
/* Copied from asm/sysreg.h */
#define sys_reg(op0, op1, crn, crm, op2) \
        ((((op0)&3)<<19)|((op1)<<16)|((crn)<<12)|((crm)<<8)|((op2)<<5))

asm(
"       .irp    num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30\n"
"       .equ    __reg_num_x\\num, \\num\n"
"       .endr\n"
"       .equ    __reg_num_xzr, 31\n"
"\n"
"       .macro  mrs_s, rt, sreg\n"
"       .inst   0xd5200000|(\\sreg)|(__reg_num_\\rt)\n"
"       .endm\n"
"\n"
"       .macro  msr_s, sreg, rt\n"
"       .inst   0xd5000000|(\\sreg)|(__reg_num_\\rt)\n"
"       .endm\n"
);
///

#define get_cpu_ftr(id) ({					\
		unsigned long long __val;			\
		asm("mrs %0, "#id : "=r" (__val));		\
		printf("%-20s: 0x%016lx\n", #id, __val);	\
	})
#define __get_id_reg(id) ({						\
		unsigned long long __val;				\
		asm("mrs_s %0, "#id : "=r" (__val));			\
		printf("%-20s: 0x%016lx\n", get_id_str(id), __val);	\
	})
#define get_id_reg(x) __get_id_reg(x)

#define get_id_range(CRm) \
	get_id_reg(sys_reg(3, 0, 0, CRm, 0)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 1)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 2)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 3)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 4)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 5)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 6)); \
	get_id_reg(sys_reg(3, 0, 0, CRm, 7));

#define Op0(id)		(((id) >> 19) & 0x3)
#define Op1(id)		(((id) >> 16) & 0x7)
#define CRn(id)		(((id) >> 12) & 0xf)
#define CRm(id)		(((id) >> 8) & 0xf)
#define Op2(id)		(((id) >> 5) & 0x7)

char *get_id_str(int id)
{
	static char buf[64];

	sprintf(buf, "S%d_%d_%d_%d_%d",
			Op0(id), Op1(id), CRn(id), CRm(id), Op2(id));
	return buf;
}

main()
{
	get_id_range(1);
	get_id_range(2);
	get_id_range(3);
	get_id_range(4);
	get_id_range(5);
	get_id_range(6);
	get_id_range(7);
	get_cpu_ftr(MIDR_EL1);
	get_cpu_ftr(REVIDR_EL1);
	get_cpu_ftr(MPIDR_EL1);

	/* Trap */
	get_id_reg(sys_reg(3, 0, 0, 0, 2));
	return 0;
}
